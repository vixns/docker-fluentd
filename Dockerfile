FROM fluent/fluentd:v1.0
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH
RUN apk --no-cache --update add build-base ruby-dev geoip geoip-dev libmaxminddb libmaxminddb-dev snappy-dev ruby-bundler \
    && gem install \
    fluent-plugin-prometheus \
    zookeeper \
    snappy \
    fluent-plugin-kafka \
    fluent-plugin-s3 \
    fluent-plugin-sentry \
    fluent-plugin-elasticsearch \
    strptime \
    geoip2_c \
    geoip2_compat \
    fluent-plugin-multi-format-parser \
    fluent-plugin-genhashvalue \
    fluent-plugin-geoip \
    && rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && gem sources -c \
    && apk del build-base ruby-dev geoip-dev libmaxminddb-dev ruby-bundler && rm -rf /var/cache/apk/*

EXPOSE 24224
COPY fluent.conf /fluentd/etc/

CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
