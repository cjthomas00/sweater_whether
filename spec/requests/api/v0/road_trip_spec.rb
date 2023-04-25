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
    expect(parsed_data[:data][:attributes][:weather_at_eta][:datetime]).to eq("04-25-2023 03:00 PM")
    expect(parsed_data[:data][:attributes][:weather_at_eta][:temperature]).to eq(49.5)
    expect(parsed_data[:data][:attributes][:weather_at_eta][:condition]).to eq("Patchy light rain with thunder")
    end
  end
end