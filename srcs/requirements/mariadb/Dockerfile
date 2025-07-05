FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y mariadb-server
COPY ./tools/config.sh /config.sh
RUN chmod +x /config.sh
ENTRYPOINT [ "/config.sh" ]
