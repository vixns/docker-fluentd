FROM kiyoto/fluentd:0.12.3-2.2.0
MAINTAINER stephane.cottin@vixns.com
RUN ["/usr/local/bin/gem", "install", "fluent-plugin-record-reformer", "fluent-plugin-docker-format", "fluent-plugin-kafka", "fluent-plugin-docker-metrics", "fluent-plugin-elasticsearch", "fluent-plugin-multi-format-parser", "--no-rdoc", "--no-ri"]
RUN mkdir /etc/fluent /var/log/docker
ADD fluent.conf /etc/fluent/

ENTRYPOINT ["/usr/local/bundle/bin/fluentd", "-c", "/etc/fluent/fluent.conf"]
