class ImpossibleTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = "impossible"
    @weather_at_eta = {}
  end
end