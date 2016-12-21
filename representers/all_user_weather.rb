class AllUserWeatherRepresenter
  def initialize(user_weathers)
    @user_weathers = user_weathers
  end

  def to_json
    {user_weathers: @user_weathers}.to_json
  end
end
