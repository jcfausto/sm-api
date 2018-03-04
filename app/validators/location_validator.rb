# frozen_string_literal: true

# app/validators/location_validator.rb

##
# This class is responsible for validating a location. A location is composed
# of latitude, longitude and an optional parameter, radius.
class LocationValidator < BaseSearchFilterValidator
  attr_reader :latitude, :longitude

  def initialize(params)
    super()
    if params
      @latitude = params[:latitude]
      @longitude = params[:longitude]
    end
  end

  def valid?
    add_error(ValidationMessages.invalid_location) unless valid_lat_long?
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
end
