require "rails_helper"

RSpec.describe "Forecast API" do
  before :each do
    get "/api/v1/forecast?location=cincinnati,oh"
    @parsed_data = JSON.parse(response.body, symbolize_names: true)
  end

  it "returns data" do
    expect(@parsed_data).to be_a(Hash)
    expect(@parsed_data).to have_key(:data)
  end

  it "has id, type, and attributes" do
    expect(@parsed_data[:data]).to have_key(:id)
    expect(@parsed_data[:data][:id]).to eq(null)

    expect(@parsed_data[:data]).to have_key(:type)
    expect(@parsed_data[:data][:type]).to eq("forecast")

    expect(@parsed_data[:data]).to have_key(:attributes)
  end
end