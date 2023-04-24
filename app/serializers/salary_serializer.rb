class SalarySerializer
  def initialize(destination, data, weather)
    @destination
    require 'pry'; binding.pry
    @data = data
    @weather = weather
  end

  def combo_serializer
      {
        data: {
          id: nil,
          type: "salries",
          attributes: {
            destination: @destination,
             "forecast": {
              "summary": @weather[:condition],
              "temperature": @weather[:temperature]
            },
            salaries: @data.map do |salary|
              {
                "job": salary[:job][:title],
                "min_salary": salary[:salary_percentiles][:percentile_25].to_i,
                "max_salary": salary[:salary_percentiles][:percentile_75].to_i
              }
            end,
          }
        }
      }
  end
end