require "rails_helper"

RSpec.describe ImpossibleTrip, :vcr do
  it "exists" do
    impossible_trip = RoadTripFacade.get_road_trip("denver,co", "hamburg,de")
    expect(impossible_trip).to be_a(ImpossibleTrip)
  end
end