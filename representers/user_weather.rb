class UserWeatherRepresenter < Roar::Decorator
  include Roar::JSON

  property :location
  property :icon
  property :upload_time

end
