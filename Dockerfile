FROM alpine:3.14

RUN \
    echo "[] Installing build dependencies..." && \
        apk add --no-cache --virtual=build-dependencies \
            bzip2 gcc make unzip wget autoconf automake && \
    echo "[] Installing runtime packages..." && \
        apk add --no-cache \
            bind-tools curl inotify-tools jq perl perl-digest-sha1 \
            perl-io-socket-inet6 perl-io-socket-ssl perl-json && \
    echo "[] Installing perl modules..." && \
        curl -L http://cpanmin.us | perl - App::cpanminus && \
        cpanm Data::Validate::IP JSON::Any && \
    echo "[] Installing ddclient..." && \
        wget "https://github.com/ddclient/ddclient/archive/refs/heads/develop.zip" -P /tmp/ && \
        pushd /tmp/ && \
        unzip develop.zip && \
        cd ddclient-develop && \
        ./autogen && \
        ./configure --prefix=/usr --sysconfdir=/etc/ddclient --localstatedir=/var && \
        make && \
        make VERBOSE=1 check && \
        make install && \
        popd && \
    echo "[] Cleaning up..." && \
        apk del --purge build-dependencies && \
        rm -rf /config/.cpanm /root/.cpanm /tmp/*

VOLUME /etc/ddclient

ENTRYPOINT ["/usr/bin/ddclient", "-foreground"]
