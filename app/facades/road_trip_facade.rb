class RoadTripFacade

  def self.get_road_trip(origin, destination)
    response = RoadtripService.get_road_trip(origin, destination)
    arrival_time = formatted_time(response[:route][:formattedTime])
    future_cast = destination_weather(destination, arrival_time)
    RoadTrip.new(response, future_cast)
  end

  private 

  def self.formatted_time(travel_time)
    time = Time.now
    formatted_time = Time.strptime(travel_time, "%H:%M:%S")
    arrival_time = time + formatted_time.hour.hours + formatted_time.min.minutes + formatted_time.sec.seconds
    arrival_time.strftime("%m-%d-%Y %I:%M %p")
  end

  def self.destination_weather(destination, arrival_time)
    info = MapquestService.get_location(destination)
    lat_lng = info[:results][0][:locations][0][:latLng]
    coords = Location.new(lat_lng)
    response = WeatherService.get_forecasted_weather(coords)
    forecast = Weather.new(response)
    future_cast = forecast.hourly_weather.find do |hour|
      a = Time.strptime(hour[:time], "%m-%d-%Y %I:%M %p")
      b = Time.strptime(arrival_time, "%m-%d-%Y %I:%M %p")
      c = Time.at(a) > Time.at(b)
    end
  end
end