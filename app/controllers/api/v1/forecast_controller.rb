class Api::V1::ForecastController < ApplicationController
  def index
  location = LocationFacade.get_location(params[:location])
  end
end