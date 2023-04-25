class ForecastSerializer
  def initialize(data)
    @data = data 
  end

  def weather_serializer
      {
        data: {
          id: nil,
          type: "forecast",
          attributes: {
            current_weather: {
              last_updated: @data.current_weather[:last_updated],
              temperature: @data.current_weather[:temperature],
              feels_like: @data.current_weather[:feels_like],
              humidity: @data.current_weather[:humidity],
              uvi: @data.current_weather[:uvi],
              visibility: @data.current_weather[:visibility],
              condition: @data.current_weather[:condition],
              icon: @data.current_weather[:icon]
            },
            daily_weather: @data.daily_weather.map do |day|
              {
              date: day[:date],
              sunrise: day[:sunrise],
              sunset: day[:sunset],
              max_temp: day[:max_temp],
              min_temp: day[:min_temp],
              condition: day[:condition],
              icon: day[:icon]
            }
            end,
            hourly_weather: @data.hourly_weather.map do |day|
              day.map do |hour|
                { 
                time: hour[:time],
                temperature: hour[:temperature],
                conditions: hour[:conditions],
                icon: hour[:icon]
              }
            end
          end
          }
        }
      }
  end
end
