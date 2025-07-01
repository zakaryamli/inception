FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y nginx openssl
COPY ./tools/config.sh /config.sh
RUN chmod +x /config.sh && /config.sh
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
