#!/bin/bash -e

cd /app

mkdir -p tmp/pids/
rm -f tmp/pids/*.pid

if [ "$RAILS_ENV" == "development" ]; then
  exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
else
  USER_DATA=$(curl --fail http://169.254.169.254/latest/user-data || echo "")

  if [ "$USER_DATA" == "EMERGENCY_MODE" ]
  then
    git pull
  fi

  bin/rails db:migrate

  if [ -f "commit_id.txt" ]
  then
    cp commit_id.txt public/
  fi

  if [ -f /run/secrets/environment ]
  then
      source /run/secrets/environment
  fi

  exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
fi
