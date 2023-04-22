require "rails_helper"

RSpec.describe "Forecast API", :vcr do
  describe "when location is valid" do
    before :each do 
      get "/api/v1/forecast?location=denver,co"
      @parsed_data = JSON.parse(response.body, symbolize_names: true)
    end

    it "returns data" do

      expect(response).to be_successful
    
      expect(@parsed_data).to be_a(Hash)
      expect(@parsed_data).to have_key(:data)
    
      expect(@parsed_data[:data].keys).to eq([:id, :type, :attributes])
      expect(@parsed_data[:data][:id]).to eq(nil)
      expect(@parsed_data[:data][:type]).to eq("forecast")
      expect(@parsed_data[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
    end

    # Current Weather
    it "returns current weather" do
      expect(@parsed_data[:data][:attributes][:current_weather].keys).to eq([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])
      expect(@parsed_data[:data][:attributes][:current_weather][:last_updated]).to be_a(String)      
      expect(@parsed_data[:data][:attributes][:current_weather][:temperature]).to be_a(Float)      
      expect(@parsed_data[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)      
      expect(@parsed_data[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)      
      expect(@parsed_data[:data][:attributes][:current_weather][:uvi]).to be_a(Float)      
      expect(@parsed_data[:data][:attributes][:current_weather][:visibility]).to be_a(Float)      
      expect(@parsed_data[:data][:attributes][:current_weather][:condition]).to be_a(String)      
      expect(@parsed_data[:data][:attributes][:current_weather][:icon]).to be_a(String) 
      expect(@parsed_data[:data][:attributes][:current_weather]).to_not have_key(:sunrise)
      expect(@parsed_data[:data][:attributes][:current_weather]).to_not have_key(:is_day)
      expect(@parsed_data[:data][:attributes][:current_weather]).to_not have_key(:cloud)
    end

    # Daily Weather
    it "returns daily weather" do
      expect(@parsed_data[:data][:attributes][:daily_weather].size).to eq(5)
      expect(@parsed_data[:data][:attributes][:daily_weather].first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon])
      expect(@parsed_data[:data][:attributes][:daily_weather].first[:date]).to be_a(String)
      expect(@parsed_data[:data][:attributes][:daily_weather].first[:sunrise]).to be_a(String)
      expect(@parsed_data[:data][:attributes][:daily_weather].first[:sunset]).to be_a(String)
      expect(@parsed_data[:data][:attributes][:daily_weather].first[:max_temp]).to be_a(Float)
      expect(@parsed_data[:data][:attributes][:daily_weather].first[:min_temp]).to be_a(Float)
      expect(@parsed_data[:data][:attributes][:daily_weather].first[:condition]).to be_a(String)
      expect(@parsed_data[:data][:attributes][:daily_weather].first[:icon]).to be_a(String)
      expect(@parsed_data[:data][:attributes][:daily_weather].first).to_not have_key(:date_epoch)
      expect(@parsed_data[:data][:attributes][:daily_weather].first).to_not have_key(:maxwind_kph)
    end

    # Hourly Weather
    it "returns hourly weather" do
      expect(@parsed_data[:data][:attributes][:hourly_weather].size).to eq(24)
      expect(@parsed_data[:data][:attributes][:hourly_weather].first.keys).to eq([:time, :temperature, :conditions, :icon])
      expect(@parsed_data[:data][:attributes][:hourly_weather].first[:time]).to be_a(String)
      expect(@parsed_data[:data][:attributes][:hourly_weather].first[:temperature]).to be_a(Float)
      expect(@parsed_data[:data][:attributes][:hourly_weather].first[:conditions]).to be_a(String)
      expect(@parsed_data[:data][:attributes][:hourly_weather].first[:icon]).to be_a(String)
      expect(@parsed_data[:data][:attributes][:hourly_weather].first).to_not have_key(:date_epoch)
      expect(@parsed_data[:data][:attributes][:hourly_weather].first).to_not have_key(:maxwind_kph)
      expect(@parsed_data[:data][:attributes][:hourly_weather].first).to_not have_key(:cloud)
      expect(@parsed_data[:data][:attributes][:hourly_weather].first).to_not have_key(:date_epoch)
      expect(@parsed_data[:data][:attributes][:hourly_weather].first).to_not have_key(:maxwind_kph)
    end
  end
end