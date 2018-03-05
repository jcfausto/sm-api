#frozen_string_literal: true

# app/controllers/authentication_controller.rb

##
# Controller responsible for authenticate client's credentials
class AuthenticationController < ApplicationController
  def authenticate
    auth_token = AuthenticationService.new(
      auth_params['email'],
      auth_params['password']
    ).call

    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
