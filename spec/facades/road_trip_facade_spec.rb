require "rails_helper"

RSpec.describe RoadTripFacade, :vcr do
  describe "class methods" do
    it "#get_road_trip" do
      road_trip = RoadTripFacade.get_road_trip("denver,co", "pueblo,co")

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.start_city).to be_a(String)
      expect(road_trip.end_city).to be_a(String)
      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.weather_at_eta).to be_a(Hash)
      expect(road_trip.weather_at_eta.keys).to eq([:datetime, :temperature, :condition])
      expect(road_trip.weather_at_eta[:datetime]).to be_a(String)
      expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
      expect(road_trip.weather_at_eta[:condition]).to be_a(String)
    end

    it "#get_road_trip sad path" do
      road_trip = RoadTripFacade.get_road_trip("denver,co", "london,uk")

      expect(road_trip).to be_a(ImpossibleTrip)
      expect(road_trip.start_city).to be_a(String)
      expect(road_trip.end_city).to be_a(String)
      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.travel_time).to eq("impossible")
      expect(road_trip.weather_at_eta).to be_a(Hash)
    end
  end
end