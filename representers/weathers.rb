class AllWeatherRepresenter < Roar::Decorator
  include Roar::JSON

  property :weather
end
