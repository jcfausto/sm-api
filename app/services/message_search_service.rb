# frozen_string_literal: true

# app/services/message_search_service.rb

##
# This service object is responsible for querying messages to the DB
class MessageSearchService
  attr_reader :search_filter, :data, :status

  def initialize(params)
    @search_filter = SearchFilterValidator.new(params)
    @data = []
    @status = :ok
    @status = :bad_request unless @search_filter.valid?
  end

  def call
    @data = @search_filter.error_messages
    @data = perform_query if @status == :ok
    self
  end

  private

  def perform_query
    location = search_filter.location
    case search_filter.message_type.type
    when :nearest
      Messages::NearestMessageQuery.call(Message, location)
    when :nearby
      Messages::NearbyMessagesQuery.call(Message, location, radius)
    end
  end

  def radius
    search_filter.radius.radius || MAXIMUM_SEARCH_RADIUS_IN_KM
  end
end
