class Api::V0::SalariesController < ApplicationController

  def index 
    destination = params[:destination]
    
    require 'pry'; binding.pry
  end
end