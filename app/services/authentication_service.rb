# frozen_string_literal: true

# app/services/authentication_service.rb

##
# This service is responsible for authenticating a user and return a valid JWT
class AuthenticationService
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode({user_id: user.id}) if user
  end

  private

  attr_reader :email, :password

  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
  end
end
