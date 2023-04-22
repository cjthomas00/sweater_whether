class WeatherFacade
  
  def self.get_forecasted_weather(location)
    response = WeatherService.get_forecasted_weather(location)
    Weather.new(response)
  end
end