class RoadTripFacade

  def self.get_road_trip(origin, destination)
    response = RoadtripService.get_road_trip(origin, destination)
    require 'pry'; binding.pry
  end
end