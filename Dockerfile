FROM fluent/fluentd:v1.3-debian-onbuild-1
USER root
RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev libgeoip-dev libmaxminddb-dev libsnappy-dev patch" \
 && apt-get update \
 && apt-get install -y --no-install-recommends libgeoip1 libmaxminddb0 $buildDeps \
 && sudo gem install \
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
    fluent-plugin-record-modifier \
    --no-document \
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem

COPY fluent.conf /fluentd/etc/
USER fluent
ENV FLUENTD_CONF=fluent.conf

CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
