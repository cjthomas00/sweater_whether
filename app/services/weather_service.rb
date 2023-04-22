class WeatherService

  def self.get_forecasted_weather(location)
    get_url("forecast.json?key=#{ENV['WEATHER_API_KEY']}&q=#{location.lat},#{location.long}&days=5")
  end

  private

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com/v1") do |faraday|
      faraday.params["key"] = ENV['WEATHER_API_KEY']
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end