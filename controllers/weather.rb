# frozen_string_literal: true

# routes
class WeataiAPI < Sinatra::Base

  #get all station weather data(from database)
  get "/#{API_VER}/weather/?" do
<<<<<<< HEAD
    result = FindAllWeathers.call
=======
    begin
      weather = Weather.all
      content_type 'application/json'
      { instant_weather: weather}.to_json
>>>>>>> master

    if result.success?
      AllWeatherRepresenter.new(weathers: result).to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end

  #get only one station weather data(from database)
  get "/#{API_VER}/weather/:station/?" do
<<<<<<< HEAD
    result = FindWeather.call(params[:station])
=======
    station = params[:station]
    #station_num = (station.to_i.modulo(39)+1)
    begin
      weather = Weather.find(station: station)
      #if there has no weather info. of this station in DB
      halt 400, "weather of (station: #{station_num}) not found" unless weather
      
      #if there has weather info. of this station in DB, output it
      content_type 'application/json'
      { #id:         weather., 
        station:    weather.station, 
        stationName:weather.stationName,
        city:       weather.city,                       #station's city
        township:   weather.township,                   #station's township
        temperature:weather.temperature,                #station's temperature
        humidity:   weather.humidity,                   #relative humidity(HUMD)相對濕度
        MIN_10:     weather.MIN_10,                     #10min rainfall十分鐘雨量
        rainfall:   weather.rainfall,                   #station's rainfall(day)雨量
        AirQuality: weather.AirQuality,                 #AirQuality 空氣品質(環保署)
        Status:     weather.Status,                     #AirStatus
        time:       weather.time }.to_json
    rescue
      halt 404, "Instant weather not found(by station)"
    end
  end
>>>>>>> master

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
