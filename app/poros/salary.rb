class Salary
require 'action_view'
include ActionView::Helpers::NumberHelper

  attr_reader :title,
              :min,
              :max

  def initialize(salary_data)
    @title = salary_data[:job][:title]
    @min = monetize(salary_data[:salary_percentiles][:percentile_25].to_f.round(2)).to_s
    @max = monetize(salary_data[:salary_percentiles][:percentile_75].to_f.round(2)).to_s
  end

  def monetize(value)
    value = number_to_currency(value, precision: 0)
  end
end