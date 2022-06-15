#!/bin/sh
# Run Migrations

echo <<EOF

╭━━━╮╭╮╱╱╱╱╱╭╮╱╱╱╱╱╱╱╭━━━╮╭╮╱╱╱╱╱╱╭╮
┃╭━╮┣╯╰╮╱╱╱╭╯╰╮╱╱╱╱╱╱┃╭━╮┣╯╰╮╱╱╱╱╱┃┃
┃╰━━╋╮╭╋━━┳┻╮╭╋╮╭┳━━╮┃╰━━╋╮╭╋━━┳━━┫┃╭╮
╰━━╮┃┃┃┃╭╮┃╭┫┃┃┃┃┃╭╮┃╰━━╮┃┃┃┃╭╮┃╭━┫╰╯╯
┃╰━╯┃┃╰┫╭╮┃┃┃╰┫╰╯┃╰╯┃┃╰━╯┃┃╰┫╭╮┃╰━┫╭╮╮
╰━━━╯╰━┻╯╰┻╯╰━┻━━┫╭━╯╰━━━╯╰━┻╯╰┻━━┻╯╰╯
╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱┃┃
╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╰╯
EOF

echo "Startup stack starting..."
echo -e "\e[1mCommit:\e[0m ${COMMIT}"

if [ -n "$RAILS_ENV" ]
  then
    echo "RAILS_ENV is $RAILS_ENV"
  else
    echo 'RAILS_ENV not set, default to production'
    export RAILS_ENV='production'
fi



if [ -n "$SKIP_MIGRATIONS" ]
  then
	echo "SKIP_MIGRATIONS is set. Skipping Migrations."
  else
	bundle exec rake db:migrate
fi

echo "Starting SSH Server"
/usr/sbin/sshd -o "SetEnv=RAILS_ENV=\"$RAILS_ENV\" DATABASE_URL=\"$DATABASE_URL\" GEM_HOME=\"$GEM_HOME\" SECRET_KEY_BASE=stubbed"

echo "## Migrations complete. Starting app."
# Start App
bundle exec rails server -b 0.0.0.0