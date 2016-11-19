# frozen_string_literal: true

# routes
class WeataiAPI < Sinatra::Base

  #get all station weather data(from database)
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

  #get only one station weather data(from database)
  get "/#{API_VER}/weather/:station/?" do
    station = params[:station]
    begin
      weather = Weather.find(stationID: station)
      #if there has no weather info. of this station in DB
      halt 400, "weather of (station: #{station}) not found" unless weather
      
      #if there has weather info. of this station in DB, output it
      content_type 'application/json'
      { id:         weather.id, 
        station:    weather.station, 
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

  #get all station weather data(from internet)
  get "/#{API_VER}/weather_i/?" do
    begin
      weather = CWB::INSTANT.instant
      content_type 'application/json'
      { instant_weather: weather}.to_json

    rescue
      content_type 'text/plain'
      halt 404, "Instant weather not found"
    end
  end

  #get only one station weather data(from internet)
  get "/#{API_VER}/weather_i/:station/?" do
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
      DB[:weathers].delete
      
      #Weather.delete_all
      

      weather.each do |key, value|
      Weather.create(
        #stationID:   value['Station'],
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
=begin
  

  

    put "/#{API_VER}/weather/?" do
    begin
      #posting_id = params[:id]
      #posting = Posting.find(id: posting_id)
      #halt 400, "Posting (id: #{posting_id}) is not stored" unless posting
      #updated_posting = FaceGroup::Posting.find(id: posting.fb_id)
      #if updated_posting.nil?
       # halt 404, "Posting (id: #{posting_id}) not found on Facebook"
      #end

      weather = CWB::INSTANT.instant
      weather.each do |key, value|
      weatrer.update(
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
      weather.save

      content_type 'text/plain'
      body ''
    rescue
      content_type 'text/plain'
      halt 500, "Cannot update weather"
    end
=end    
  end
end