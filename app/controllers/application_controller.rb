# frozen_string_literal: true

# app/controllers/application_controller.rb

##
# Main application controller
class ApplicationController < ActionController::Base
  before_action :authorize_request

  attr_reader :current_user

  # Includes
  include Response

  def unauthorized_route
    json_response({status: "unauthorized"}, :unauthorized)
  end

  private

  def authorize_request
    @current_user = AuthorizationService.new(request.headers).call
  rescue StandardError => error
    json_response({ error: error.message }, :unauthorized)
  end
end
