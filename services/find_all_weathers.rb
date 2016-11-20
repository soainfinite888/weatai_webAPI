class FindAllWeathers
  extend Dry::Monads::Either::Mixin

  def self.call
    if (weathers = Weather.all).empty?
      Left(Error.new(:not_found, 'Weathers not found'))
    else
      Right(weathers)
    end
  end
end
