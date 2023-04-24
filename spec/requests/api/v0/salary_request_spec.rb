require "rails_helper"

RSpec.describe "Teleport Salary API", :vcr do
  describe "when location is valid" do
    before :each do
      location = "denver"
      get "/api/v0/salaries?destination=#{location}"
      @parsed_data = JSON.parse(response.body, symbolize_names: true)
    end

    it "returns data" do
      expect(response).to be_successful

      expect(@parsed_data).to be_a(Hash)
      require 'pry'; binding.pry
    end
  end
end