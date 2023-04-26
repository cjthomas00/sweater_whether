class ImpossibleTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, arrival_time = nil)
    @id = nil
    @start_city = origin
    @end_city = destination
    if arrival_time != nil
      @travel_time = "Arrival Time is greater than 5 days from now. An accurate forecast cannot be calculated."
    else
      @travel_time = "impossible"
    end
    @weather_at_eta = {}
  end
end