require "rails_helper"

RSpec.describe MapquestService do
  describe "class methods" do
    it "get_location" do
      json = JSON.parse(File.read('spec/fixtures/mapquest_cincinnati.json'), symbolize_names: true)
      allow(MapquestService).to receive(:get_location).and_return(json)
      expect(MapquestService.get_location("cincinnati,oh")).to be_a(Hash)
    end
  end
end