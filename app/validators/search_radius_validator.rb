# app/validators/search_radius_validator.rb

##
# This class is responsible for validating the user informed search radius
class SearchRadiusValidator < BaseSearchFilterValidator
  attr_reader :radius

  def initialize(params)
    super()
    @radius = params[:radius] if params
  end

  def valid?
    add_error(ValidationMessages.invalid_radius) if radius && !valid_radius?
    error_messages.empty?
  end

  private

  ##
  # Validate if radius is a number and is within the limit
  def valid_radius?
    return false unless radius = float?(radius)
    radius.positive? && radius <= MAXIMUM_SEARCH_RADIUS_IN_KM
  end
end
