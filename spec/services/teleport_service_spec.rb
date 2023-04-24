require "rails_helper"

RSpec.describe TeleportService, :vcr do
  describe "class methods" do
    it "get_salaries" do
      salaries = TeleportService.get_salaries("denver")
      expect(salaries).to be_a(Hash)
    end
  end
end