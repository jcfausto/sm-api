# frozen_string_literal: true

# app/queries/nearest_message_query.rb

module Messages
  ##
  # This query object is responsible for fetching the nearest message to a
  # certain location
  class NearestMessageQuery
    ORDER_BY_DISTANCE = 'distance'

    def self.call(relation, location)
      location = [location.latitude, location.longitude]
      radius = MAXIMUM_SEARCH_RADIUS_IN_KM
      relation
        .near(location, radius, units: :km, order: ORDER_BY_DISTANCE)
        .first
    end
  end
end
