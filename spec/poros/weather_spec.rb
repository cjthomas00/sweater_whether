require "rails_helper"

RSpec.describe Weather, :vcr do 
  it "exists" do
    location = LocationFacade.get_location("cincinnati,oh")
    weather = WeatherFacade.get_forecasted_weather(location)
    expect(weather).to be_a(Weather)
  end
end