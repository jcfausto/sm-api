# frozen_string_literal: true

# app/validators/location_validator_spec.rb

##
# This class is responsible for validating a location. A location is composed
# of latitude, longitude and an optional parameter, radius.
class LocationValidator < BaseSearchFilterValidator
  attr_reader :latitude, :longitude, :radius

  def initialize(params)
    super()
    @latitude = params[:latitude] if params
    @longitude = params[:longitude] if params
    @radius = params[:radius] if params
  end

  def valid?
    add_error(ValidationMessages.invalid_location) unless valid_lat_long?
    add_error(ValidationMessages.invalid_radius) if radius && !valid_radius?
    error_messages.empty?
  end

  private

  ##
  # Validate if latitude and longitude are numbers and within the range
  def valid_lat_long?
    float?(latitude) && float?(longitude) &&
      latitude.to_f.between?(VALID_LATITUDE[:min], VALID_LATITUDE[:max]) &&
      longitude.to_f.between?(VALID_LONGITUDE[:min], VALID_LONGITUDE[:max])
  end

  ##
  # Validate if radius is a number and is within the limit
  def valid_radius?
    float?(radius) && valid_search_radius?(radius.to_f)
  end

  ##
  # Checks if radius is valid from product's rules perspective
  def valid_search_radius?(radius)
    radius.positive? && radius <= MAXIMUM_SEARCH_RADIUS_IN_KM
  end

  ##
  # Validates if the value is a Float number
  def float?(value)
    true if Float(value)
  rescue StandardError
    false
  end
end
