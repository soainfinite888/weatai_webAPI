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
end
