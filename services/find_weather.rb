class FindWeather
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    if (weather = Weather.find(station: params)).nil?
      Left(Error.new(:not_found, 'Station weather not found'))
    else
      Right(weather)
    end
  end
  
  def self.async_weather_updates(weathers_repr) 
  	promised_updates = weathers_repr.FindWeather.map do ||
      Concurrent::Promise.execute { self.call(stationdid) } 
    end
    promised_updates.map(&:value) 
  end
end
