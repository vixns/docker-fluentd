FROM kiyoto/fluentd:0.12.3-2.2.0
MAINTAINER stephane.cottin@vixns.com
RUN mkdir /etc/fluent /var/log/docker
ADD fluent.conf /etc/fluent/
RUN ["/usr/local/bin/gem", "install", "fluent-plugin-record-reformer", "--no-rdoc", "--no-ri"]
RUN ["/usr/local/bin/gem", "install", "fluent-plugin-docker-format", "--no-rdoc", "--no-ri"]
RUN ["/usr/local/bin/gem", "install", "fluent-plugin-kafka", "--no-rdoc", "--no-ri"]
RUN ["/usr/local/bin/gem", "install", "fluent-plugin-elasticsearch", "--no-rdoc", "--no-ri"]

ENTRYPOINT ["/usr/local/bundle/bin/fluentd", "-c", "/etc/fluent/fluent.conf"]
