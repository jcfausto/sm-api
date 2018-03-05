# frozen_string_literal: true

# app/controllers/user_controller.rb

##
# Controller class for the User model
class UserController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # POST /user/signup
  def create
    User.create!(user_params)

    auth_token = AuthenticationService.new(
      user_params['email'],
      user_params['password']
    ).call

    json_response({ auth_token: auth_token }, :created)
  rescue StandardError => error
    json_response({
      result: "#{ResponseMessages.unprocessable_entity}: #{error.message}"
    }, :unprocessable_entity)
  end

  private

  def user_params
    params.require('user').permit(:username, :email, :password, :password_confirmation)
  end
end
