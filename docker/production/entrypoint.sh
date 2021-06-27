#!/bin/bash

sudo service nginx start
cd /app
RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bin/rails db:migrate:reset
RAILS_ENV=production bin/rails assets:precompile
bundle exec pumactl start