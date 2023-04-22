class MapquestService

  def self.get_location(city_state)
    get_url("address?key=#{ENV['MAPQUEST_API_KEY']}&location=#{city_state}")
  end

  private 

  def self.conn 
    Faraday.new(url:"https://www.mapquestapi.com/geocoding/v1/") do |faraday|
      faraday.params["key"] = ENV['MAPQUEST_API_KEY']
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end