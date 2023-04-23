require "rails_helper"

RSpec.describe "User Login", :vcr do
  before :each do
    user_params = 
    {
       email: "email123@gmail.com",
       password: "baloney1",
       password_confirmation: "baloney1"
    }
    post "/api/v0/users", params: user_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
  end

  describe "happy path" do
    it "can login a user and return a 200 status code" do
      user_login_params = 
      {
         email: "email123@gmail.com",
         password: "baloney1"
      }
       expect(User.count).to eq(1)
       post "/api/v0/sessions", params: user_login_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
       expect(response.status).to eq(200)
       expect(response.content_type).to eq("application/json; charset=utf-8")

       parsed_data = JSON.parse(response.body, symbolize_names: true)

       expect(parsed_data).to be_a(Hash)
       expect(parsed_data).to have_key(:data)
       expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
       expect(parsed_data[:data][:attributes]).to have_key(:email)
       expect(parsed_data[:data][:attributes]).to have_key(:api_key)
       expect(parsed_data[:data][:attributes]).to_not have_key(:password)
    end
  end

  describe "sad path" do
    it "returns a 401 status code if email doesn't exist" do
      user_login_params = 
      {
         email: "email123@aol.com",
         password: "baloney1"
      }
      post "/api/v0/sessions", params: user_login_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data).to have_key(:error)
      expect(parsed_data[:error]).to eq("Invalid credentials")
    end

    it "returns a 401 status code if password is incorrect" do
      user_login_params = 
      {
         email: "email123@gmail.com",
         password: "baloney12"
      }
      post "/api/v0/sessions", params: user_login_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data).to have_key(:error)
      expect(parsed_data[:error]).to eq("Invalid credentials")
    end

    it "returns a 401 status code if email is blank" do
      user_login_params = 
      {
         email: "",
         password: "baloney12"
      }
      post "/api/v0/sessions", params: user_login_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data).to have_key(:error)
      expect(parsed_data[:error]).to eq("1 or More Fields are Missing")
    end

    it "returns a 401 status code if password is blank" do
      user_login_params = 
      {
         email: "email123@gmail.com",
         password: ""
      }
      post "/api/v0/sessions", params: user_login_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data).to have_key(:error)
      expect(parsed_data[:error]).to eq("1 or More Fields are Missing")
    end

    it "returns a 401 status code if email and password are blank" do
      user_login_params = 
      {
         email: "",
         password: ""
      }
      post "/api/v0/sessions", params: user_login_params, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data).to have_key(:error)
      expect(parsed_data[:error]).to eq("1 or More Fields are Missing")
    end
  end
end