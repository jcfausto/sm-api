# frozen_string_literal: true

# app/validators/message_type_validator.rb

##
# This class is responsible for validating the supported message query types
class MessageTypeValidator < BaseSearchFilterValidator
  attr_reader :type

  def initialize(params)
    super()
    @type = params[:type]&.to_sym if params
  end

  ##
  # A message query type is valid when it is included into the
  # api's valid message types object (Hash)
  def valid?
    add_error(ValidationMessages.unsupported_message_query_type) unless
      VALID_MESSAGE_TYPES.keys.include?(type)
    error_messages.empty?
  end
end
