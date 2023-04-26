require "rails_helper"

RSpec.describe "Road Trip Creation", :vcr do
  describe "happy path" do
    it "can create a new road trip and return a 201 status code" do
      user = User.create!(email: "getmail@gmail.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
      body = {  
      "origin": "Loveland,CO",
      "destination": "Grand Junction,CO",
      "api_key": "jgn983hy48thw9begh98h4539h4"
      }
      post "/api/v0/road_trip", params: body, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(201)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_data).to be_a(Hash)
      expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
      expect(parsed_data[:data][:id]).to eq(nil)
      expect(parsed_data[:data][:type]).to eq("road_trip")
      expect(parsed_data[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(parsed_data[:data][:attributes][:start_city]).to eq("Loveland, CO")
      expect(parsed_data[:data][:attributes][:end_city]).to eq("Grand Junction, CO")
      expect(parsed_data[:data][:attributes][:travel_time]).to eq("04:26:14")
      expect(parsed_data[:data][:attributes][:weather_at_eta].keys).to eq([:datetime, :temperature, :condition])
    end
  end

  describe "happy path long trip" do
    it "can create a new road trip and return a 201 status code" do
      user = User.create!(email: "getmail@gmail.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
      body = {  
      "origin": "New York,NY",
      "destination": "Los Angeles,CA",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
    post "/api/v0/road_trip", params: body, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
    expect(response.status).to eq(201)
    expect(response.content_type).to eq("application/json; charset=utf-8")
    
    parsed_data = JSON.parse(response.body, symbolize_names: true)
  
    expect(parsed_data).to be_a(Hash)
    expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
    expect(parsed_data[:data][:id]).to eq(nil)
    expect(parsed_data[:data][:type]).to eq("road_trip")
    expect(parsed_data[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
    expect(parsed_data[:data][:attributes][:start_city]).to eq("New York, NY")
    expect(parsed_data[:data][:attributes][:end_city]).to eq("Los Angeles, CA")
    expect(parsed_data[:data][:attributes][:travel_time]).to eq("40:15:59")
    expect(parsed_data[:data][:attributes][:weather_at_eta].keys).to eq([:datetime, :temperature, :condition])
    end
  end
  
  describe "sad path" do
    it "returns an error if the api key is incorrect" do
      user = User.create!(email: "getmail@gmail.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
      body = {  
      "origin": "Loveland,CO",
      "destination": "Grand Junction,CO",
      "api_key": "wrong_api_key"
      }
      post "/api/v0/road_trip", params: body, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data[:error]).to eq("Unauthorized")
    end

    it "returns an error if the api key is missing" do
      user = User.create!(email: "getmail@gmail.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
      body = {  
      "origin": "Loveland,CO",
      "destination": "Grand Junction,CO",
      "api_key": ""
      }
      post "/api/v0/road_trip", params: body, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data[:error]).to eq("Missing Parameters, Unable to Process")
    end

    it "returns an error if the origin is missing" do
      user = User.create!(email: "getmail@gmail.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
      body = {  
      "origin": "",
      "destination": "Grand Junction,CO",
      "api_key": "jgn983hy48thw9begh98h4539h4"
      }
      post "/api/v0/road_trip", params: body, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data[:error]).to eq("Missing Parameters, Unable to Process")
    end

    it "returns an error if the destination is missing" do
      user = User.create!(email: "getmail@gmail.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
      body = {  
      "origin": "Loveland,CO",
      "destination": "",
      "api_key": "jgn983hy48thw9begh98h4539h4"
      }
      post "/api/v0/road_trip", params: body, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(401)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data[:error]).to eq("Missing Parameters, Unable to Process")
    end
  end
  
  describe "edge case" do
    it "returns a message for impossible trip" do
      user = User.create!(email: "getmail@gmail.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
      
      body = {  
      "origin": "Loveland,CO",
      "destination": "London,UK",
      "api_key": "jgn983hy48thw9begh98h4539h4"
      }
      post "/api/v0/road_trip", params: body, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      expect(response.status).to eq(201)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data[:data][:attributes][:travel_time]).to eq("impossible")
      expect(parsed_data[:data][:attributes][:weather_at_eta]).to eq({})
    end

    it "returns a message for a trip longer than 5 days" do
      user = User.create!(email: "getmail@gmail.com", password: "password", password_confirmation: "password", api_key: "jgn983hy48thw9begh98h4539h4")
      
      body = {  
      "origin": "Anchrage,AK",
      "destination": "Panama City, Panama",
      "api_key": "jgn983hy48thw9begh98h4539h4"
      }
      post "/api/v0/road_trip", params: body, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
      
      
      expect(response.status).to eq(201)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_data[:data][:attributes][:travel_time]).to eq("120 hours")
      expect(parsed_data[:data][:attributes][:weather_at_eta]).to eq("The current travel time will not allow for an accurate weather forecast.")
    end
  end
end