# app/controllers/concerns/search_filter_validator.rb

##
# This class is responsible for validating the search filters
class SearchFilterValidator < BaseSearchFilterValidator
  attr_reader :message_type, :location

  def initialize(params)
    super()
    @message_type = MessageTypeValidator.new(params)
    @location = LocationValidator.new(params)
  end

  def valid?
    add_error(message_type.error_messages) unless message_type.valid?
    add_error(location.error_messages) unless location.valid?
    return error_messages.empty?
  end

end
