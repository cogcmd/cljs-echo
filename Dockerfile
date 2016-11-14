FROM frolvlad/alpine-oraclejdk8:latest

RUN adduser -h /home/bundle -D bundle && \
    mkdir -p /home/bundle && \
    chown -R bundle /home/bundle

WORKDIR /home/bundle

RUN apk -U add ca-certificates wget unzip libstdc++ && \
    wget https://github.com/anmonteiro/lumo/releases/download/1.0.0-alpha2/lumo_linux64.zip && \
    unzip lumo_linux64.zip && \
    mv lumo /usr/bin/ && \
    rm lumo_linux64.zip && \
    apk del ca-certificates wget unzip && \
    rm -f /var/cache/apk/*

COPY cljs-echo.cljs cljs-echo.sh /home/bundle/

USER bundle
