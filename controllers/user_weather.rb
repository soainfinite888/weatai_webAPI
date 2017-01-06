# frozen_string_literal: true

# routes
class WeataiAPI < Sinatra::Base
  post "/#{API_VER}/user_weather/?" do
    
    params = JSON.parse request.body.read
    res = CreateNewUserWeatherWorker.perform_async(params)
    puts "WORKER: #{res}"
    status 202
  end

  get "/#{API_VER}/user_weather/all/?" do
    begin
      all_user_weather = UserWeather.where(:upload_time => (Time.now-7200) .. Time.now).all
      AllUserWeatherRepresenter.new(all_user_weather).to_json
    rescue
      ErrorRepresenter.new(Error.new(:not_found, 'User weather could not be found')).to_status_response
    end
  end
end
