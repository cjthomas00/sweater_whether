class Api::V0::SalariesController < ApplicationController

  def index 
    name = params[:destination]
    destination = LocationFacade.get_location(params[:destination])
    forecast = WeatherFacade.get_forecasted_weather(destination).current_weather
    salaries = SalaryFacade.get_salaries(params[:destination])
    render json: SalarySerializer.new(name, salaries, forecast).salaries_serializer
  end
end