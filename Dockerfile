FROM fluent/fluentd:v0.14-latest
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH
USER root
RUN apk --no-cache --update add sudo build-base ruby-dev geoip-dev \
    && sudo -u fluent gem install \
    fluent-plugin-prometheus \
    zookeeper \
    fluent-plugin-kafka \
    fluent-plugin-s3 \
    fluent-plugin-elasticsearch \
    fluent-plugin-geoip \
    strptime \
    && rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && sudo -u fluent gem sources -c \
    && apk del sudo build-base ruby-dev && rm -rf /var/cache/apk/*

EXPOSE 24224
COPY fluent.conf /fluentd/etc/

USER fluent
CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
