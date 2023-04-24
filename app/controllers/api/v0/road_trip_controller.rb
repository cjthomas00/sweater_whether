class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = RoadTripFacade.get_road_trip(params[:origin], params[:destination])
      weather = WeatherFacade.get_forecasted_weather(road_trip.destination)
    else
      render json: { error: "Unauthorized" }, status: 401
    end
  end
end