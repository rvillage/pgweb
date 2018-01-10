FROM alpine:3.7 AS setup

RUN set -ex \
  && apk --update --upgrade add --no-cache \
    ca-certificates \
    openssl-dev \
    unzip \
    wget

ENV PGWEB_VERSION 0.9.11
RUN set -ex \
  && wget https://github.com/sosedoff/pgweb/releases/download/v${PGWEB_VERSION}/pgweb_linux_amd64.zip \
  && unzip pgweb_linux_amd64.zip \
  && mv pgweb_linux_amd64 /bin/pgweb \
  && chmod +x /bin/pgweb

# build image
FROM alpine:3.7
LABEL maintainer "rvillage <rvillage@gmail.com>"

COPY --from=setup /bin/pgweb /bin/pgweb

EXPOSE 8081

ENTRYPOINT ["pgweb", "-s", "--bind=0.0.0.0"]
