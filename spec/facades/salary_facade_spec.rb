require "rails_helper"

RSpec.describe SalaryFacade, :vcr do
  describe "class methods" do
    it "get_salaries" do
      destination = "denver"
      salaries = SalaryFacade.get_salaries(destination)
      expect(salaries).to be_a(Array)
    end
  end
end