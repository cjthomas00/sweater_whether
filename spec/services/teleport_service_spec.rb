require "rails_helper"

RSpec.describe TeleportService, :vcr do
  describe "class methods" do
    it "get_teleport_id" do
      id = TeleportService.get_teleport_id("denver")
      expect(id).to be_a(Hash)
    end
  end
end