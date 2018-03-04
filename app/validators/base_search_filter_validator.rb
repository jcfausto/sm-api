# frozen_string_literal: true

# app/validators/base_search_filter_validator.rb
require_relative 'messages/validation_messages'

##
# Base class for search filters validation
class BaseSearchFilterValidator
  attr_reader :error_messages

  def initialize
    @error_messages = []
  end

  protected

  ##
  # Add an error message to error_messages object
  def add_error(error)
    error_messages << error
  end

  ##
  # Validates if the value is a Float number
  def float?(value)
    true if Float(value)
  rescue StandardError
    false
  end
end
