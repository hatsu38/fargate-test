FROM ruby:2.7.2 AS base

WORKDIR /app
ENV RAILS_ENV production
ENV NODE_MAJOR_VERSION 14

RUN gem update --system && gem install bundler:2.1.4

# builder
FROM base AS builder

RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR_VERSION.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    vim locales build-essential curl libpq-dev libmariadb-dev nodejs yarn nginx sudo

# bundle
FROM builder AS bundle

COPY Gemfile Gemfile.lock .
RUN bundle install --deployment --without development:test --path vendor/bundle && rm -rf vendor/bundle/ruby/$RUBY_VERSION/cache/*

# yarn
FROM builder AS yarn

COPY package.json yarn.lock .
RUN yarn install --production --frozen-lockfile && yarn cache clean

# main
FROM builder AS main

COPY . .

COPY --from=bundle /app/vendor/bundle /app/vendor/bundle
COPY --from=yarn /app/node_modules /app/node_modules

# nginx
RUN groupadd nginx
RUN useradd -g nginx nginx
ADD docker/production/nginx.conf /etc/nginx/nginx.conf
ADD docker/production/entrypoint.sh /app/entrypoint.sh

EXPOSE 80

RUN chmod +x /app/entrypoint.sh