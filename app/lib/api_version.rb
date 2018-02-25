# app/lib/api_version.rb

##
# This class is responsible for checking the api version requested.
# If the version is not supported, will default to the one informed on the
# routes config
class ApiVersion
  attr_reader :version, :default

  def initialize(version, default = false)
    @version = version
    @default = default
  end

  ##
  # Check if the api version is specific or default
  def matches?(request)
    check_headers(request.headers) || default
  end

  private

  ##
  # Check if a version was defined in Accept header
  def check_headers(headers)
    accept = headers[:accept]
    accept&.include?("application/vnd.messages.#{version}+json")
  end
end
