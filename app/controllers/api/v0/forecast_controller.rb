class Api::V0::ForecastController < ApplicationController
  def index
  location = LocationFacade.get_location(params[:location])
  weather = WeatherFacade.get_forecasted_weather(location)
  render json: ForecastSerializer.new(weather)
  end
end