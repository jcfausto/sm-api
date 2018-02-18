# app/validators/base_search_filter_validator.rb

##
# Base class for search filters validation
class BaseSearchFilterValidator
  attr_reader :error_messages

  def initialize
    @error_messages = []
  end

  protected

  def add_error(error)
    error_messages << error
  end
end
