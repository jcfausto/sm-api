class Message < ApplicationRecord
	# To be able to compare two messages and decide which one is closer to a certain location
	include Comparable

	# Geocoder setup
	require 'geocoder'
	reverse_geocoded_by :latitude, :longitude
	
	# Arbitrary default for message length
	MESSAGE_CONTENT_LENGTH = 300

	# Validations
	# Validates content presence and length based on application setup
	validates_presence_of :content
	validates_length_of :content, maximum: MESSAGE_CONTENT_LENGTH
	# Validates presence, range and numericality of latitude
	validates_presence_of :latitude
	validates_inclusion_of :latitude, in: -90..90
	validates_numericality_of :latitude, on: :create
	# Validates presence, range and numericality of longitude
	validates_presence_of :longitude
	validates_inclusion_of :longitude, in: -180..180
	validates_numericality_of :longitude, on: :create
end
