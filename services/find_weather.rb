class FindWeather
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    if (weather = Weather.find(station: params)).nil?
      Left(Error.new(:not_found, 'Station weather not found'))
    else
      Right(weather)
    end
  end
end
