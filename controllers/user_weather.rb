# frozen_string_literal: true

# routes
class WeataiAPI < Sinatra::Base
  post "/#{API_VER}/user_weather/?" do
    begin
      body_params = JSON.parse request.body.read
      UserWeather.create(
        location: body_params['location'],
        icon: body_params['icon'],
        upload_time: body_params['upload_time'],
      )
      'success'
    rescue
      content_type 'text/plain'
      halt 400, "User weather could not be saved"
    end
  end
  get "/#{API_VER}/user_weather/all/?" do
    begin
      all_user_weather = UserWeather.where(:upload_time => (Time.now-7200) .. Time.now).all
      all_user_weather.to_json
    rescue
      content_type 'text/plain'
      halt 400, "User weather could not be found"
    end
  end
end
