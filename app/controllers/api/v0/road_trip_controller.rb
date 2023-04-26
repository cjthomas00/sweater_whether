class Api::V0::RoadTripController < ApplicationController
  before_action :check_values
  wrap_parameters :user, include: [:email, :password, :password_confirmation]
  
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = RoadTripFacade.get_road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip), status: 201
    else
      render json: { error: "Unauthorized" }, status: 401
    end
  end

  private

  def check_values
    if params[:origin].empty? || params[:destination].empty? || params[:api_key].empty?
      render json: { error: "Missing Parameters, Unable to Process" }, status: 401
    end
  end

end