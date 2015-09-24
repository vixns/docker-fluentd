FROM gliderlabs/alpine:3.2
MAINTAINER stephane.cottin@vixns.com

ENV FLUENTD_VERSION 0.12.15

RUN apk-install ca-certificates ruby-dev build-base jemalloc-dev && \
  echo 'gem: --no-document' >> /etc/gemrc && \
  gem update --system && \
  gem install fluentd -v $FLUENTD_VERSION && \
  gem install fluent-plugin-td && \
  gem install fluent-plugin-rewrite-tag-filter && \
  gem install fluent-plugin-kafka && \
  gem install fluent-plugin-multi-format-parser && \
  gem install fluent-plugin-docker-tag-resolver && \
  fluentd --setup /etc/fluent

ENV JEMALLOC_PATH /usr/lib/libjemalloc.so
COPY fluentd.conf /etc/fluent/fluent.conf
ENTRYPOINT ["/usr/bin/fluentd", "-c", "/etc/fluent/fluent.conf"]
