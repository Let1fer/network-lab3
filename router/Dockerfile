FROM alpine:latest

# Укажите пользователя root
USER root

# Установите iptables
RUN apk add --no-cache iptables

# Скопируйте скрипт с правилами iptables в контейнер
COPY do.sh /usr/local/bin/do.sh

# Сделайте скрипт исполняемым
RUN chmod +x /usr/local/bin/do.sh



# Запустите скрипт при старте контейнера
CMD sh -c "/usr/local/bin/do.sh"
