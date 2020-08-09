FROM elixir:1.10

RUN mix local.hex --force \
 && mix local.rebar --force \
 && mix archive.install hex phx_new 1.5.4 --force \
 && apt-get update \
 && curl -sL https://deb.nodesource.com/setup_12.x | bash \
 && apt-get install -y apt-utils \
 && apt-get install -y nodejs \
 && apt-get install -y build-essential \
 && apt-get install -y inotify-tools \
 && apt-get install -y postgresql-client

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
COPY ./entrypoint.sh /entrypoint.sh

WORKDIR $APP_HOME

EXPOSE 4000
