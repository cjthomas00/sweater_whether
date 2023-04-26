require "rails_helper"

RSpec.describe Location do
  it "exists" do
    coordinates = {lat: 39.103118, lng: -84.512020}  
    expect(Location.new(coordinates)).to be_a(Location)
    expect(Location.new(coordinates).lat).to eq(39.103118)
    expect(Location.new(coordinates).long).to eq(-84.512020)
  end
end