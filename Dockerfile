FROM alpine:3.20

RUN apk add --no-cache git busybox-extras

WORKDIR /repo

RUN git clone --depth 1 --branch master https://github.com/NX211/homer-icons.git . \
  && mkdir -p /www

COPY index.html /opt/homer-icons/index.html
COPY scripts/update-icons.sh /usr/local/bin/update-icons.sh
COPY scripts/gallery-manifest.cgi /usr/local/bin/gallery-manifest.cgi
COPY scripts/start.sh /usr/local/bin/start.sh
COPY VERSION /etc/homer-icons-container-version

RUN chmod +x \
  /usr/local/bin/update-icons.sh \
  /usr/local/bin/gallery-manifest.cgi \
  /usr/local/bin/start.sh

EXPOSE 8080

ENV BASE_URL=
ENV UPDATE_ON_STARTUP=0

CMD ["/usr/local/bin/start.sh"]
