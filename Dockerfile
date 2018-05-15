FROM alpine:3.7 AS setup

ENV PGWEB_VERSION 0.9.12

RUN set -ex \
  && apk --update upgrade \
  && wget https://github.com/sosedoff/pgweb/releases/download/v${PGWEB_VERSION}/pgweb_linux_amd64.zip \
  && unzip pgweb_linux_amd64.zip \
  && mv pgweb_linux_amd64 /bin/pgweb \
  && chmod +x /bin/pgweb

# build image
FROM alpine:3.7
LABEL maintainer "rvillage <rvillage@gmail.com>"

COPY --from=setup /bin/pgweb /bin/pgweb

RUN apk --update upgrade

EXPOSE 8081
ENTRYPOINT ["pgweb", "-s", "--bind=0.0.0.0"]
