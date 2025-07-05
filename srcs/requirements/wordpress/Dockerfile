FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl php php-mysql php7.4-fpm mariadb-client
COPY ./tools/config.sh /
RUN chmod +x /config.sh
ENTRYPOINT [ "/config.sh" ] 
