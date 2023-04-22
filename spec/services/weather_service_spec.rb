require "rails_helper"

RSpec.describe WeatherService, :vcr do
  describe "class methods" do
    it "get_weather" do
      coordinates = LocationFacade.get_location("cincinnati,oh")
      expect(WeatherService.get_forecasted_weather(coordinates)).to be_a(Hash)
      expect(WeatherService.get_forecasted_weather(coordinates).keys).to eq([:location, :current, :forecast])
    end
  end
end