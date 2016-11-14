# frozen_string_literal: true

require 'sequel'

Sequel.migration do 
  change do
    create_table(:C_weather) do 
      primary_key :station  #station's name觀測站名稱
      String :time #data's time 
      String :city  #station's city
      String :township  #station's township
      Float  :temperature  #station's temperature
      Float  :humidity #relative humidity(HUMD)相對濕度
      Float  :MIN_10 #10min rainfall十分鐘雨量
      Float  :rainfall #station's rainfall(day)雨量
      String :AirQuality #AirQuality 空氣品質(環保署)
    end
  end
end