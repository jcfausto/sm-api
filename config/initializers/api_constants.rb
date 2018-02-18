# config/initializers/api_constants.rb

##
# API constants used throughout the system

# Default API version in case an unsupported version is requested
DEFAULT_API_VERSION = 'v1'.freeze

# Message types supported for GET requests
VALID_MESSAGE_TYPES = {nearby: "nearby", nearest: "nearest"}.freeze

# Valid latitude range
VALID_LATITUDE = {min: -90, max: 90}.freeze

# Valid longitude range
VALID_LONGITUDE = {min: -180, max: 180}.freeze

# Maximum search radius allowed in KM
MAXIMUM_SEARCH_RADIUS_IN_KM = 100.freeze

# Message content maximum length
MESSAGE_CONTENT_LENGTH = 300.freeze
