# frozen_string_literal: true

# app/controllers/concerns/search_filter_validator.rb

##
# This class is responsible for validating the search filters
class SearchFilterValidator < BaseSearchFilterValidator
  attr_reader :message_type, :location, :radius

  def initialize(params)
    super()
    @message_type = MessageTypeValidator.new(params)
    @location = LocationValidator.new(params)
    @radius = SearchRadiusValidator.new(params)
  end

  ##
  # Search filter is valid when message query type is supported
  # and location and radius are valid
  def valid?
    add_error(message_type.error_messages) unless message_type.valid?
    add_error(location.error_messages) unless location.valid?
    add_error(radius.error_messages) unless radius.valid?
    error_messages.empty?
  end
end
