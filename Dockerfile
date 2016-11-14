FROM alpine:3.4

RUN adduser -h /home/bundle -D bundle && \
    mkdir -p /home/bundle && \
    chown -R bundle /home/bundle

WORKDIR /home/bundle

RUN apk -U add bash curl git openjdk7-jre nodejs python make g++ linux-headers
RUN curl -fsSLo boot https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh && \
    chmod +x boot && \
    mv boot /usr/local/bin
RUN npm install --global yarn
RUN git clone https://github.com/anmonteiro/lumo.git && \
    cd lumo && \
    BOOT_AS_ROOT=yes boot release; echo 0 && \
    mv build/lumo /usr/local/bin && \
    rm -rf /home/bundle/lumo

COPY cljs-echo.cljs cljs-echo.sh /home/bundle/

USER bundle
