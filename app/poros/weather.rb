class Weather
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = parsed_current_weather(data)
    @daily_weather = parsed_daily_weather(data)
    @hourly_weather = parsed_hourly_weather(data)
  end

  def parsed_current_weather(data)
    { 
      last_updated: date_time_conversion(data[:current][:last_updated]),
      temperature: data[:current][:temp_f],
      feels_like: data[:current][:feelslike_f],
      humidity: data[:current][:humidity],
      uvi: data[:current][:uv],
      visibility: data[:current][:vis_miles],
      condition: data[:current][:condition][:text],
      icon: data[:current][:condition][:icon]
    }
  end

  def parsed_daily_weather(data)
    data[:forecast][:forecastday].map do |day|
      { 
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def parsed_hourly_weather(data)
    data[:forecast][:forecastday].map do |day|
      day[:hour].map do |hour|
        {
        time: readable_24_hour_time(hour[:time]),
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
        }
      end
    end
  end

  def date_time_conversion(date_time)
    conversion = Time.parse(date_time)
    date = conversion.strftime("%m-%d-%Y %I:%M %p")
  end

  def readable_24_hour_time(time)
    date_time = Time.parse(time)
    result = date_time.strftime("%m-%d-%Y %I:%M %p")
  end
end