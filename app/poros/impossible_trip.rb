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
      @travel_time = "#{arrival_time} hours"
      @weather_at_eta = "The current travel time will not allow for an accurate weather forecast."
    else
      @travel_time = "impossible"
      @weather_at_eta = {}
    end
  end
end