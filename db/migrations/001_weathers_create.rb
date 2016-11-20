# frozen_string_literal: true
require 'sequel'

Sequel.migration do 
  change do
    create_table(:weathers) do #create weather's'
      primary_key :id #:primary_key=>true #station's ID
      String :station #station's id
      String :stationName #station's name
      String :city  #station's city
      String :township  #station's township
      String :temperature  #station's temperature
      String :humidity #relative humidity(HUMD)相對濕度
      String :MIN_10 #10min rainfall十分鐘雨量
      String :rainfall #station's rainfall(day)雨量
      String :AirQuality #AirQuality 空氣品質(環保署)
      String :Status 
      String :time #data's time 
    end
  end
end