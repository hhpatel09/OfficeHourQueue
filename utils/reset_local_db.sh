#!/usr/bin/env bash
bundle exec rake db:migrate;
bundle exec rake db:schema:load;
bundle exec rake db:seed;
