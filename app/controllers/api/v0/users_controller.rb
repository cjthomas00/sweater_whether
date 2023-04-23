class Api::V0::UsersController < ApplicationController
  before_action :check_passwords, :check_email, only: [:create]

  def create
    user = User.new(user_params)
    user[:api_key] = SecureRandom.hex(24)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: { error: "Email already exists" }, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def check_passwords
    if user_params[:password] != user_params[:password_confirmation]
      render json: { error: "Passwords do not match" }, status: 401
    elsif user_params[:password] == "" || user_params[:password_confirmation] == ""
      render json: { error: "Password cannot be blank" }, status: 401
    end
  end

  def check_email
   if user_params[:email] == ""
      render json: { error: "Email cannot be blank" }, status: 401
    end
  end
end