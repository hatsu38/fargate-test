FROM ruby:2.7.2 AS base

WORKDIR /app
ENV RAILS_ENV production
ENV RACK_ENV production
ENV NODE_MAJOR_VERSION 14
ENV BUNDLE_DEPLOYMENT true
ENV BUNDLE_PATH vendor/bundle
ENV BUNDLE_WITHOUT development:test
RUN gem update --system && gem install bundler:2.1.4

# builder
FROM base AS builder

RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR_VERSION.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    vim locales build-essential curl libpq-dev libmariadb-dev nodejs yarn

# bundle
FROM builder AS bundle

COPY Gemfile Gemfile.lock /app/
RUN bundle install --jobs=4 --retry=3 && rm -rf $BUNDLE_PATH/ruby/$RUBY_VERSION/cache/*

# yarn
FROM builder AS yarn

COPY package.json yarn.lock /app/
RUN yarn install --production --frozen-lockfile && yarn cache clean

# main
FROM builder AS main

COPY . /app/

COPY --from=bundle /app/vendor/bundle /app/vendor/bundle
COPY --from=yarn /app/node_modules /app/node_modules

ADD docker/production/entrypoint.sh /app/entrypoint.sh

EXPOSE 3000

RUN chmod +x /app/entrypoint.sh
