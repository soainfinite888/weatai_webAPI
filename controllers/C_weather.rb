# frozen_string_literal: true

# routes
class WeataiAPI < Sinatra::Base

  #get all station weather data
  get "/#{API_VER}/C_weather/?" do
    begin
      weather = CWB::INSTANT.instant
      content_type 'application/json'
      { instant_weather: weather}.to_json
    rescue
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

  #put function
  put "/#{API_VER}/C_weather/:station/?"
    begin
      station = params[:station]  #station name
      weather = CWB::INSTANT.local(:station)
      content_type 'application/json'
      {instant_weather: weather}.to_json
     

      updated_weather = 

      weather.update(
        :time #data's time 
        :city  #station's city
        :township  #station's township
        :temperature  #station's temperature
        :humidity #relative humidity(HUMD)相對濕度
        :MIN_10 #10min rainfall十分鐘雨量
        :rainfall #station's rainfall(day)雨量
        :AirQuality #AirQuality 空氣品質(環保署)
      )
      content_type 'text/plain'
      body ''
    rescue
      content_type 'text/plain'
      halt 500, "Cannot update weather (#{station})"
    end
  end
end

