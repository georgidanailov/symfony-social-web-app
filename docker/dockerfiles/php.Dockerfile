FROM ediormbg/devops-php:dev838

ARG UID
ARG GID
ARG UNAME
ARG USERNAME

RUN if [ "$UNAME" = "Linux" ]; then \
    addgroup --gid $GID nonroot && \
    adduser --uid $UID --gid $GID --disabled-password --gecos "" nonroot && \
    echo 'nonroot ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    USER nonroot \
; else echo "THIS IS MAC" ; fi

RUN mkdir /var/www/tmp
RUN chown $USERNAME:$USERNAME /var/www/tmp

RUN apt update && apt install tmux -y

USER $USERNAME

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV COMPOSER_MEMORY_LIMIT -1
ENV HISTFILE /var/www/tmp/.bash_history
ENV MYSQL_HISTFILE /var/www/tmp/.mysql_history

RUN echo 'alias p="php -d memory_limit=512M"' >> ~/.bashrc && \
    echo 'alias pdsu="p bin/console doctrine:schema:update --dump-sql -f"' >> ~/.bashrc && \
    echo 'alias pb="p bin/console"' >> ~/.bashrc && \
    echo 'alias ydw="yarn dev --watch"' >> ~/.bashrc && \
    echo 'alias composer="php -d memory_limit=-1 /usr/local/bin/composer"' >> ~/.bashrc && \
    echo 'set -g mouse on' >> ~/.tmux.conf && \
    echo 'alias ll="ls -lAhF --time-style=long-iso"' >> ~/.bashrc && \
    echo 'function e() { tmux new -d -s awesome-dev-session \; split-window -v \; send-keys -t awesome-dev-session.0 "tail -100f var/log/dev.log | grep '\''CRITICAL'\''" ENTER \; send-keys -t awesome-dev-session.1 "pb server:dump" ENTER \; attach -t awesome-dev-session; }' >> ~/.bashrc && \
    echo 'function ee() { tmux new -d -s awesome-dev-session \; split-window -h \; split-window -v \; send-keys -t awesome-dev-session.1 "tail -100f var/log/dev.log | grep '\''CRITICAL'\''" ENTER \; send-keys -t awesome-dev-session.2 "pb server:dump" ENTER \; attach -t awesome-dev-session; }' >> ~/.bashrc
