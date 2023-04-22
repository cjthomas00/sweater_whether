class LocationFacade

  def self.get_location(city_state)
    response = MapquestService.get_location(city_state)
    coordinates = response[:results][0][:locations].first[:latLng]
    Location.new(coordinates)
  end
end