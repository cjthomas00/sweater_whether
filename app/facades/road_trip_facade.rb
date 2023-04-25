class RoadTripFacade

  def self.get_road_trip(origin, destination)
    response = RoadtripService.get_road_trip(origin, destination)
    if response[:info][:statuscode] == 402
      return ImpossibleTrip.new(origin, destination)
    else
      arrival_time = formatted_time(response[:route][:formattedTime])
      future_cast = destination_weather(destination, arrival_time).compact.first
      RoadTrip.new(response, future_cast)
    end
  end

  private 

  def self.formatted_time(travel_time)
    time = Time.now
    hour, minute, second = travel_time.split(":").map(&:to_i)
    seconds = hour * 3600 +  minute * 60 + second
    arrival_time = time + seconds
    arrival_time.strftime("%m-%d-%Y %I:%M %p")
  end

  def self.destination_weather(destination, arrival_time)
    info = MapquestService.get_location(destination)
    lat_lng = info[:results][0][:locations][0][:latLng]
    coords = Location.new(lat_lng)
    response = WeatherService.get_forecasted_weather(coords)
    forecast = Weather.new(response)
    future_cast = forecast.hourly_weather.map do |hour|
      hour.find do |time|
        a = Time.strptime(time[:time], "%m-%d-%Y %I:%M %p")
        b = Time.strptime(arrival_time, "%m-%d-%Y %I:%M %p")
        c = Time.at(a) > Time.at(b)
      end
    end
  end
end