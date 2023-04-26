class Api::V0::SessionsController < ApplicationController
  before_action :check_fields
  wrap_parameters :user, include: [:email, :password, :password_confirmation]
  
  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      render json: UserSerializer.new(user), status: 200
    else 
      render json: { error: "Invalid credentials" }, status: 401
    end
  end

  private 

  def user_params
    params.permit(:email, :password)
  end

  def check_fields
    if user_params[:email] == "" || user_params[:password] == ""
      render json: {error: "1 or More Fields are Missing"}, status: 401
    end
  end
end