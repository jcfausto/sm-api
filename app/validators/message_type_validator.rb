# app/validators/message_type_validator.rb

##
# This class is responsible for validating the supported message query types
class MessageTypeValidator < BaseSearchFilterValidator
  attr_reader :type

  def initialize(params)
    super()
    if params
      @type = params[:type].to_sym rescue nil
    end
  end

  def valid?
    add_error(ValidationMessages.unsupported_message_query_type) unless
      VALID_MESSAGE_TYPES.keys.include?(type)
    return error_messages.empty?
  end
end
