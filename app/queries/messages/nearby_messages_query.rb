# frozen_string_literal: true

# app/queries/nearby_messages_query.rb
module Messages
  ##
  # This class is responsible for fetching messages nearby to a location within
  # a certain radius
  class NearbyMessagesQuery
    ORDER_BY_DISTANCE = 'distance'

    def self.call(relation, location, radius)
      relation.near([location.latitude, location.longitude],
                    radius, units: :km, order: ORDER_BY_DISTANCE)
    end
  end
end
