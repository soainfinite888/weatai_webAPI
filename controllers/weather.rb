# frozen_string_literal: true

# routes
class WeataiAPI < Sinatra::Base

  #get all station weather data
  get "/#{API_VER}/weather/?" do
    begin
      weather = CWB::INSTANT.instant
      content_type 'application/json'
      { instant_weather: weather}.to_json

    rescue
      content_type 'text/plain'
      halt 404, "Instant weather not found"
    end
  end

  #get only one station weather data 
  get "/#{API_VER}/weather/:station/?" do
    begin
      weather = CWB::INSTANT.local(:station)
      content_type 'application/json'
      { instant_weather: weather}.to_json
    rescue
      halt 404, "Instant weather not found"
    end
  end

  #post function(all station)
  post "/#{API_VER}/weather/?" do
    begin
      weather = CWB::INSTANT.instant
      if weather.nil? == true 
        halt 404, "Instant weather not found"  
      end  
      #DB[:groups].delete  #清空table

      weather.each do |key, value|
      Weather.create(
        station:     value['Station'],
        city:        value['City'],                        #station's city
        township:    value['Town'],                        #station's township
        temperature: value['Temp'],                        #station's temperature
        humidity:    value['Humd'] ,                       #relative humidity(HUMD)相對濕度
        MIN_10:      value['Last 10 minutes Rainfall'],    #10min rainfall十分鐘雨量
        rainfall:    value['Daily Accumulated Rainfall'],  #station's rainfall(day)雨量
        AirQuality:  value['PSI'],                         #AirQuality 空氣品質(環保署)
        Status:      value['Status'],                      #AirStatus
        time:        value['Time'],                        #data's time 
      )
      end

      content_type 'text/plain'
      "Post Instant weather success(save to database)"

    rescue
      content_type 'text/plain'
      halt 500, "Cannot update Instant weather"
    end
  end
end