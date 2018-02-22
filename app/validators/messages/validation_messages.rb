# app/lib/messages.rb

##
# This class is responsible for storing all messages related to validations.
# All messages here should be freezed so that we optimize memory allocation.
class ValidationMessages

  ##
  # Unsupported message query type
  def self.unsupported_message_query_type
    "Message query type not supported.".freeze
  end

  ##
  # Invalid location (latitude or longitude)
  def self.invalid_location
    "Invalid location (latitude or longitude)".freeze
  end

  ##
  # Invalid radius
  def self.invalid_radius
    "Invalid radius".freeze
  end

end
