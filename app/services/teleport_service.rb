class TeleportService
  
  def self.get_salaries(location)
    get_url("urban_areas/slug:#{location}/salaries/")
  end
  
  private

  def self.conn
    Faraday.new(url: "https://api.teleport.org/api/")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end