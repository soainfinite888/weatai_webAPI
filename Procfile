web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-production}
worker: shoryuken -r ./workers/create_new_user_weather_worker.rb -C ./workers/shoryuken.yml
