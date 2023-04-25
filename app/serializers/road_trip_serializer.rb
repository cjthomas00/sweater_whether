class RoadTripSerializer
  include JSONAPI::Serializer
  attributes :start_city, :end_city, :travel_time
  attribute :weather_at_eta do |object|
    { 
      datetime: object.arrival_time,
      temperature: object.temperature,
      condition: object.conditions
    }
  end
end
