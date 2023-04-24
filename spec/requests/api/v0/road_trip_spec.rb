require "rails_helper"

RSpec.describe "Road Trip Creation", :vcr do
  describe "happy path" do
    it "can create a new road trip and return a 201 status code" do
      body = {  
      "origin": "Denver,CO",
      "desination": "Pueblo,CO",
      "api_key": "jgn983hy48thw9begh98h4539h4"
      }
    post "/api/v0/road_trip", params: body, headers: { "Content_Type" => "application/json", "Accept" => "application/json" }, as: :json
    expect(response.status).to eq(201)
    parsed_data = JSON.parse(response.body, symbolize_names: true)
    
    end
  end
end