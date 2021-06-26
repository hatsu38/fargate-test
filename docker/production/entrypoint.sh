#!/bin/bash

sudo service nginx start
cd /app
RAILS_ENV=production bin/rails db:schema:load
RAILS_ENV=production bin/rails assets:precompile
bundle exec pumactl start