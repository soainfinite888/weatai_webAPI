class WeatherRepresenter < Roar::Decorator
  include Roar::JSON

  property :station
  property :stationName
  property :city
  property :township
  property :temperature, type: String
  property :humidity, type: String
  property :MIN_10, type: String
  property :rainfall, type: String
  property :AirQuality, type: String
  property :Status
  property :time
end
