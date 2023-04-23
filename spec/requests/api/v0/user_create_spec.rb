require "rails_helper"

RSpec.describe "User Creation", :vcr do
  describe "happy path" do
    before :each do
     @user_params = {
      user: {
        email: "email123@gmail.com",
        password: "baloney1",
        password_confirmation: "baloney1"
        }
      }
    end

    it "can create a new user and return a 201 status code" do
      post "/api/v0/users", params: @user_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json

      expect(response.status).to eq(201)
      require 'pry'; binding.pry
    end
  end
end