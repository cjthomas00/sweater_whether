class TeleportService
  
  def self.get_salaries(teleport_id)
    get_url("urban_areas/teleport:#{teleport_id}/salaries/")
  end

  def self.get_teleport_id(location)
    get_url("urban_areas/slug:#{location}/")
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