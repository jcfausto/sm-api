# frozen_string_literal: true

# app/models/message.rb

##
# This class define the Message model, its attributes and validations
class Message < ApplicationRecord
  # Geocoder setup
  require 'geocoder'
  reverse_geocoded_by :latitude, :longitude

  ##
  # Validations:
  #   - :content presence and length based on application configuration.
  #   - :latitude numericality and valid range
  #   - :longitude numericality and valid range
  validates_presence_of :content
  validates_length_of :content, maximum: MESSAGE_CONTENT_LENGTH
  # Validates presence, range and numericality of latitude
  validates_presence_of :latitude
  validates_inclusion_of :latitude,
                         in: VALID_LATITUDE[:min]..VALID_LATITUDE[:max]
  validates_numericality_of :latitude, on: :create
  # Validates presence, range and numericality of longitude
  validates_presence_of :longitude
  validates_inclusion_of :longitude,
                         in: VALID_LONGITUDE[:min]..VALID_LONGITUDE[:max]
  validates_numericality_of :longitude, on: :create
end
