require "rails_helper"

RSpec.describe Salary, :vcr do
  it "exists" do
    destination = "denver"
    salaries = TeleportService.get_salaries(destination)
    salary = Salary.new(salaries[:salaries].first)

    expect(salary).to be_a(Salary)
    expect(salary.title).to be_a(String)
    expect(salary.min).to be_a(String)
    expect(salary.max).to be_a(String)
  end
end