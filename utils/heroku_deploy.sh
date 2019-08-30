#!/usr/bin/env bash
git push heroku master
./utils/reset_heroku_db.sh
