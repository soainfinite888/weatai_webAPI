# frozen_string_literal: true

# routes
class WeataiAPI < Sinatra::Base
  post "/#{API_VER}/user_weather/?" do
    begin
      body_params = JSON.parse request.body.read
      UserWeather.create(
        location: body_params['location'],
        icon_weather: body_params['icon_weather'],
        icon_situation: body_params['icon_situation'],
        icon_side: body_params['icon_side'],
        icon_activity: body_params['icon_activity'],
        icon_emotion: body_params['icon_emotion'],
        icon_festival: body_params['icon_festival']
      )
      'success'
    rescue
      content_type 'text/plain'
      halt 400, "User weather could not be saved"
    end
  end
end
