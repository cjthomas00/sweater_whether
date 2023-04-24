class Salary
  attr_reader :title,
              :min,
              :max

  def initialize(salary_data)
    require 'pry'; binding.pry
    @title = salary_data[:job][:title]
    @min = monetize(salary_data[:salary_percentiles][:percentile_25].to_f.round(2)).to_s
    @max = monetize(salary_data[:salary_percentiles][:percentile_75].to_f.round(2)).to_s
  end

  def job_title(title)
    require 'pry'; binding.pry
  end

  def monetize(value)
    "$#{value}"
  end
end