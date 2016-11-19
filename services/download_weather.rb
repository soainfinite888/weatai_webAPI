# frozen_string_literal: true

# Loads data from CWB to database
class DownloadWeatherFromCWB
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :find_weather
      step :validate_weather
      step :download_weather
    end.call(params)
  end

  private_class_method


  def self.download_weather(weather)
    weather.update(
        #station:     i,
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
    weather.save
  end
end
