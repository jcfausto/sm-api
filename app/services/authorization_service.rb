# frozen_string_literal: true

# app/services/autorhization_service.rb

##
# This service is reponsible for authorizing the client request
class AuthorizationService
  def initialize(headers = {})
    @headers = headers
  end

  def call
    @user = User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => error
    raise(StandardError, "Invalid Token: #{error.message}")
  end

  private

  def decoded_auth_token
    JsonWebToken.decode(http_auth_token)
  end

  def http_auth_token
    token = @headers['Authorization']
    return token.split(' ').last if token
    raise(StandardError, 'Missing Token')
  end
end
