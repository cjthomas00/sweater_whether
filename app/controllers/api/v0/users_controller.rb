class Api::V0::UsersController < ApplicationController

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
end