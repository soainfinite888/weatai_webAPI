# frozen_string_literal: true

# routes
class WeataiAPI < Sinatra::Base

  #get all station weather data
  get "/#{API_VER}/C_weather/?" do
    begin
      weather = CWB::INSTANT.instant
      #halt 404, "Instant weather not found" unless weather
      #content_type 'application/json'
      #{instant_weather: weather}.to_json
    rescue
      content_type 'text/plain'
      halt 404, "Instant weather not found"
    end
  end

  #get only one station weather data 
  get "/#{API_VER}/C_weather/:station/?" do
    begin
      weather = CWB::INSTANT.local(:station)
      content_type 'application/json'
      { instant_weather: weather}.to_json
    rescue
      halt 404, "Instant weather not found"
    end
  end

  #post function
  post "/#{API_VER}/C_weather/:station/?" do
    begin
      weather = CWB::INSTANT.local(:station)
      content_type 'application/json'
      {instant_weather: weather}.to_json
    rescue
      content_type 'text/plain'
      halt 400, "weather could not be found"
    end
  end

  #put function
  put "/#{API_VER}/C_weather/:station/?" do
    begin
      station = params[:station]  #station name
      weather = CWB::INSTANT.local(:station)
      content_type 'application/json'
      {instant_weather: weather}.to_json
     
      #updated_weather = 
      weather.update(
        time:        weather.location['time'],  #data's time 
        city:        weather.location['city'],  #station's city
        township:    weather.location['town'],  #station's township
        temperature: weather.location['TEMP']  ,#station's temperature
        humidity:    weather.location['HUMD'] ,#relative humidity(HUMD)相對濕度
        MIN_10:      weather.location['MIN_10'],#10min rainfall十分鐘雨量
        rainfall:    weather.location['Daily Accumulated Rainfall'],#station's rainfall(day)雨量
        AirQuality:  weather.location['PSI'],#AirQuality 空氣品質(環保署)
        Status:      weather.location['Status']
      )
      weather.save

      content_type 'text/plain'
      body ''

    rescue
      content_type 'text/plain'
      halt 500, "Cannot update weather (#{station})"
    end
  end
end