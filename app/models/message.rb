class Message < ApplicationRecord
	# Validations
	# A message must have a content
	validates_presence_of :content
	# Valid latitudes are in the range of -90 and 90
	validates_presence_of :latitude, in: [-90..90]
	# Valid longitudes are in the range of -180 and 180
	validates_presence_of :longitude, in: [-180..180]
end
