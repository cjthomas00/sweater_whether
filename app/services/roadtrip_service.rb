class RoadtripService
  
  def self.get_road_trip(origin, destination)
    get_url("?key=#{ENV['MAPQUEST_API_KEY']}&from=#{origin}&to=#{destination}")
  end
  
  private 

  def self.conn 
    Faraday.new(url:"https://www.mapquestapi.com/directions/v2/route") do |faraday|
      faraday.params["key"] = ENV['MAPQUEST_API_KEY']
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end