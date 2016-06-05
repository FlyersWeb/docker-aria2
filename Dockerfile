FROM alpine:3.2
MAINTAINER Morgan Auchede <morgan.auchede@gmail.com>

# 036A9C25BF357DD4 - Tianon Gravi <tianon@tianon.xyz>
#   http://pgp.mit.edu/pks/lookup?op=vindex&search=0x036A9C25BF357DD4
ENV GOSU_VERSION="1.7" \
  GOSU_DOWNLOAD_URL="https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" \
  GOSU_DOWNLOAD_SIG="https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64.asc" \
  GOSU_DOWNLOAD_KEY="0x036A9C25BF357DD4" \
  ARIA2_VERSION=1.18.10

# Download and install gosu
#   https://github.com/tianon/gosu/releases
RUN buildDeps='curl gnupg' HOME='/root' \
  && set -x \
  && apk add --update $buildDeps \
  && gpg-agent --daemon \
  && gpg --keyserver pgp.mit.edu --recv-keys $GOSU_DOWNLOAD_KEY \
  && echo "trusted-key $GOSU_DOWNLOAD_KEY" >> /root/.gnupg/gpg.conf \
  && curl -sSL "$GOSU_DOWNLOAD_URL" > gosu-amd64 \
  && curl -sSL "$GOSU_DOWNLOAD_SIG" > gosu-amd64.asc \
  && gpg --verify gosu-amd64.asc \
  && rm -f gosu-amd64.asc \
  && mv gosu-amd64 /usr/bin/gosu \
  && chmod +x /usr/bin/gosu \
  && gosu nobody true \
  && apk del --purge $buildDeps \
  && rm -rf /root/.gnupg \
  && rm -rf /var/cache/apk/* \
  ;

RUN set -x \

    # Prepare system

    && resolve() { echo $(apk search $1 | grep "^$1-$2" | sed -e "s/$1-//g") ; } \

    && apk add -U \

    # Install packages

    && RESOLVED_ARIA2_VERSION=$(resolve aria2 $ARIA2_VERSION) \

    && apk add \
           aria2=${RESOLVED_ARIA2_VERSION:?"Impossible to find 'aria2' in version '$ARIA2_VERSION'"} \
           ca-certificates \

    && apk add --update bash \

    # Clean

    && rm -rf \
           /var/cache/apk/* \

    && mkdir -p /data \
    && mkdir -p /dataComplete

COPY aria2.conf /etc/aria2/aria2.conf
COPY oncomplete.sh /
COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]

EXPOSE 6800
CMD [ "aria2" ]
