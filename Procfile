web: bundle exec unicorn -p $PORT -c ./config/unicorn/heroku.rb
worker: env QUEUE=default bundle exec rake environment resque:work
worker_speech: env QUEUE=speech_to_text bundle exec rake environment resque:work
clock: bundle exec rake scheduler:run_scheduler
