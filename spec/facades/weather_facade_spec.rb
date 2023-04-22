require "rails_helper"

RSpec.describe "Weather Facade", :vcr do
  describe "class methods" do
    it "get_forecasted_weather" do
      location = LocationFacade.get_location("cincinnati,oh")
      expect(WeatherFacade.get_forecasted_weather(location)).to be_a(Weather)
    end
  end
end