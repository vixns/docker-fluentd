FROM kiyoto/fluentd:0.12.3-2.2.0
MAINTAINER kiyoto@treausure-data.com
RUN mkdir /etc/fluent
ADD fluent.conf /etc/fluent/
RUN ["/usr/local/bin/gem", "install", "fluent-plugin-record-reformer", "--no-rdoc", "--no-ri"]
RUN ["/usr/local/bin/gem", "install", "fluent-plugin-docker-format", "--no-rdoc", "--no-ri"]
RUN ["/usr/local/bin/gem", "install", "fluent-plugin-kafka", "--no-rdoc", "--no-ri"]

ENTRYPOINT ["/usr/local/bin/fluentd", "-c", "/etc/fluent/fluent.conf"]
