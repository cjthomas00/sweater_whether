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
      expect(@parsed_data).to have_key(:data)
      expect(@parsed_data[:data].keys).to eq([:id, :type, :attributes])
      expect(@parsed_data[:data][:id]).to eq(nil)
      expect(@parsed_data[:data][:type]).to eq("salaries")
      expect(@parsed_data[:data][:attributes]).to be_a(Hash)
      expect(@parsed_data[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
      expect(@parsed_data[:data][:attributes][:salaries]).to be_a(Array)
      expect(@parsed_data[:data][:attributes][:salaries].size).to eq(7)
      @parsed_data[:data][:attributes][:salaries].each do |salary|
        expect(salary.keys).to eq([:title, :min, :max])      
      end
      job_titles = @parsed_data[:data][:attributes][:salaries].map do |salary|
        salary[:title]
      end
      expect(job_titles).to eq(["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"])
    end
  end
end