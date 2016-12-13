# frozen_string_literal: true

# routes
class WeataiAPI < Sinatra::Base

  #get all station weather data(from database)
  get "/#{API_VER}/weather/?" do
    result = FindAllWeathers.call

    if result.success?
      AllWeatherRepresenter.new(weathers: result).to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end

  #get only one station weather data(from database)
  get "/#{API_VER}/weather/:station/?" do
    result = FindWeather.call(params[:station])

    if result.success?
      WeatherRepresenter.new(result.value).to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end

  #post function(all station)
  post "/#{API_VER}/weather/?" do
    result = DownloadWeatherFromCWB.call(request.body.read)

    if result.success?
      AllWeatherRepresenter.new(weathers: result).to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end
end
