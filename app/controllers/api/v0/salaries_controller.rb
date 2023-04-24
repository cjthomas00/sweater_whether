class Api::V0::SalariesController < ApplicationController

  def index 
    name = params[:destination]
    destination = LocationFacade.get_location(params[:destination])
    forecast = WeatherFacade.get_forecasted_weather(destination)
    weather = forecast.current_weather
    salaries = SalaryFacade.get_salaries(params[:destination])
    render json: SalarySerializer.new(name, salaries, weather).salaries_serializer
    require 'pry'; binding.pry
  end
end