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
    begin
      weather = CWB::INSTANT.instant
      if weather.nil? == true 
        halt 404, "Instant weather not found"  
      end  
     
      #Weather.delete_all(ID will not reset)      
      DB[:weathers].delete
      
      i = 0
      weather.each do |key, value|
      i = i + 1  
      Weather.create(
        #stationID:   value['Station'],
        station:     i,
        stationName: value['Station'],
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
