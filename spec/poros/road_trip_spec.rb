require "rails_helper"

RSpec.describe RoadTrip, :vcr do
  it "exists" do
    road_trip = RoadTripFacade.get_road_trip("denver,co", "pueblo,co")
    expect(road_trip).to be_a(RoadTrip)
  end
end