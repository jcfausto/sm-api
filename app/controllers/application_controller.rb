# frozen_string_literal: true

# app/controllers/application_controller.rb

##
# Main application controller
class ApplicationController < ActionController::Base
  # Includes
  include Response

  def unauthorized_route
    json_response({status: "unauthorized"}, :unauthorized)
  end
end
