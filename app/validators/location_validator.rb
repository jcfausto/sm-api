# app/validators/location_validator_spec.rb

##
# This class is responsible for validating a location. A location is composed
# of latitude, longitude and an optional parameter, radius.
class LocationValidator < BaseSearchFilterValidator
  attr_reader :latitude, :longitude, :radius

  def initialize(params)
    super()
    if params
      @latitude = params[:latitude]
      @longitude = params[:longitude]
      @radius = params[:radius]
    end
  end

  def valid?
    add_error(ValidationMessages.invalid_location) unless valid_lat_long?
    add_error(ValidationMessages.invalid_radius) unless valid_radius?
    return error_messages.empty?
  end

  private

  ##
  # Validate if latitude and longitude are numbers and within the range
  def valid_lat_long?
    (Float(latitude) && Float(longitude) rescue false) &&
    latitude.to_f.between?(VALID_LATITUDE[:min], VALID_LATITUDE[:max]) &&
    longitude.to_f.between?(VALID_LONGITUDE[:min], VALID_LONGITUDE[:max])
  end

  ##
  # Validate if radius is a number and is within the limit
  def valid_radius?
    if radius
      (Float(radius) && radius.to_f > 0 &&  radius.to_f <= MAXIMUM_SEARCH_RADIUS_IN_KM) rescue false
    else
      true
    end
  end

end
