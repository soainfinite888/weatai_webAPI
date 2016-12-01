# frozen_string_literal: true

# routes
class WeataiAPI < Sinatra::Base
  post "/#{API_VER}/user_weather/?" do
    begin
      body_params = JSON.parse request.body.read
      UserWeather.create(
        location: body_params['location'],
        weather: body_params['weather'],
        icon_weather: body_params['icon_weather'],
        icon_wear: body_params['icon_wear'],
        icon_mood: body_params['icon_mood'],
        icon_activity: body_params['icon_activity'],
        icon_festival: body_params['icon_festival'],
        icon_situation: body_params['icon_situation']
      )
      'success'
    rescue
      content_type 'text/plain'
      halt 400, "User weather could not be saved"
    end
  end
end
