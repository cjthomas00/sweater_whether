require "rails_helper"

RSpec.describe "User Creation", :vcr do
  describe "happy path" do
    it "can create a new user and return a 201 status code" do
      @user_params = {
         email: "email123@gmail.com",
         password: "baloney1",
         password_confirmation: "baloney1"
       }
      post "/api/v0/users", params: @user_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(201)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(parsed_data).to be_a(Hash)
      expect(parsed_data).to have_key(:data)
      expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
      expect(parsed_data[:data][:id]).to be_a(String)
      expect(parsed_data[:data][:type]).to eq("users")
      expect(parsed_data[:data][:attributes].keys).to eq([:email, :api_key])
      expect(parsed_data[:data][:attributes][:email]).to be_a(String)
      expect(parsed_data[:data][:attributes][:api_key]).to be_a(String)

      expect(User.find_by(email: "email123@gmail.com")).to be_a(User)
      expect(User.find_by(email: "email123@gmail.com").authenticate("baloney1")).to be_a(User)
    end
  end

  describe "sad path" do
    it "returns a 401 status code if email already exists" do
      @user_params1 = {
         email: "email123@gmail.com",
         password: "baloney1",
         password_confirmation: "baloney1"
       }
      post "/api/v0/users", params: @user_params1, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(201)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(User.count).to eq(1)
      @user_params2 = {
      user: {
        email: "email123@gmail.com",
        password: "baloney2",
        password_confirmation: "baloney2"
        }
      }
      post "/api/v0/users", params: @user_params2, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(parsed_data[:error]).to eq("Email already exists")
      expect(User.count).to eq(1)
    end

    it "returns a 401 status code if passwords don't match" do
      @user_params = {
      email: "email123@gmail.com",
      password: "baloney1",
      password_confirmation: "baloney18"
      }
      post "/api/v0/users", params: @user_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      parsed_data = JSON.parse(response.body, symbolize_names: true)
    
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(parsed_data[:error]).to eq("Passwords do not match")
      expect(User.count).to eq(0)
    end

    it "returns a 401 status code if password is blank" do
      @user_params = {
         email: "email123@gmail.com",
         password: "",
         password_confirmation: ""
       }
      post "/api/v0/users", params: @user_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(parsed_data[:error]).to eq("Password cannot be blank")
      expect(User.count).to eq(0)
    end

    it "returns a 401 status code if email is blank" do
      @user_params = {
         email: "",
         password: "baloney1",
         password_confirmation: "baloney1"
       }

      post "/api/v0/users", params: @user_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(parsed_data[:error]).to eq("Email cannot be blank")
      expect(User.count).to eq(0)
    end
  end
end