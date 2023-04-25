class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :arrival_time,
              :temperature,
              :conditions

  def initialize(data, forecast)
    @id = nil
    @start_city = data[:route][:locations][0][:adminArea5] + ", " + data[:route][:locations][0][:adminArea3]
    @end_city = data[:route][:locations][1][:adminArea5] + ", " + data[:route][:locations][1][:adminArea3]
    @travel_time = data[:route][:formattedTime]
    @arrival_time = forecast[:time]
    @temperature = forecast[:temperature]
    @conditions = forecast[:conditions]
  end
end