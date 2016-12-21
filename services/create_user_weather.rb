class CreateUserWeather
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    begin
      weather = UserWeather.create(
                  location: params['location'],
                  icon: params['icon'],
                  upload_time: params['upload_time'],
                  ) 
      Right(weather)
    rescue     
      Left(Error.new(:bad_request, 'User weather could not be saved'))
    end
  end
end
