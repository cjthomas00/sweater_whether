class SalarySerializer
  def initialize(destination, data, weather)
    @destination = destination
    @data = data
    @weather = weather
  end

  def salaries_serializer
      {
        data: {
          id: nil,
          type: "salaries",
          attributes: {
            destination: @destination,
             "forecast": {
              "summary": @weather[:condition],
              "temperature": @weather[:temperature].to_s + "F"
            },
            salaries: @data.map do |salary|
              if salary.title.include?("Data Analyst") || salary.title.include?("Data Scientist") || salary.title.include?("Mobile Developer") || salary.title.include?("QA Engineer") || salary.title.include?("Software Engineer") || salary.title.include?("Systems Administrator") || salary.title.include?("Web Developer") 
              {
                "title": salary.title,
                "min": salary.min,
                "max": salary.max
              }
            end
          end.compact
          }
        }
      }
  end
end