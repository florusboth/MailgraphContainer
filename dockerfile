FROM debian:11

ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install libparse-syslog-perl rrdtool apache2 librrds-perl libfile-tail-perl libpython3.9 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/mailgraph /var/www/mailgraph

# Copy mailgraph files
COPY mailgraph/mailgraph-init /var/mailgraph/
COPY --chmod=755 mailgraph/mailgraph.pl /var/mailgraph/
COPY mailgraph/startup.sh /var/mailgraph/

COPY mailgraph/mailgraph.css /var/www/mailgraph/
COPY --chmod=755 mailgraph/mailgraph.cgi /var/www/mailgraph/

RUN chown -R www-data:www-data /var/www/mailgraph


# Copy apache config
COPY mailgraph/mailgraph.conf /etc/apache2/sites-available/

RUN a2enmod cgid && a2ensite mailgraph


VOLUME ["/var/log/mail/mail.log", "/var/www/mailgraph/rrd"]

ENTRYPOINT ["/bin/sh", "/var/mailgraph/startup.sh"]

EXPOSE 80
