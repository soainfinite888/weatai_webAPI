# frozen_string_literal: true

# Loads data from CWB to database
class DownloadWeatherFromCWB
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :download_weather, lambda {|params|
    if (weather = CWB::INSTANT.instant).nil?
      Left(Error.new(:not_found, 'Instant weather not found'))
    else
      Right(weather)
    end
  }

  register :save_weather, lambda {|weather|
    begin
      DB[:weathers].delete
      i = 0
      weather.each do |key, value|
        i = i + 1  
        Weather.create(
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
      Right(weather)
    rescue
      Left(Error.new(:internal_server_error, 'Cannot update Instant weather to database'))
    end

  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :download_weather
      step :save_weather
    end.call(params)
  end
end
