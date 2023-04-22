class Api::V1::ForecastController < ApplicationController
  def index
  location = LocationFacade.get_location(params[:location])
  weather = WeatherFacade.get_forecasted_weather(location)
  render json: ForecastSerializer.new(weather).weather_serializer
  end
end