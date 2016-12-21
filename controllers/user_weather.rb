# frozen_string_literal: true

# routes
class WeataiAPI < Sinatra::Base
  post "/#{API_VER}/user_weather/?" do

    params = JSON.parse request.body.read
    result = CreateUserWeather.call(params)

    if result.success?
      UserWeatherRepresenter.new(result.value).to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
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
