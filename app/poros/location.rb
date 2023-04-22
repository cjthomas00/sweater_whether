class Location
  attr_reader :lat,
              :long
  
  def initialize(data)
    @lat = data[:lat]
    @long = data[:lng]
  end
end