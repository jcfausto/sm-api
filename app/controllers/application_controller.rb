# frozen_string_literal: true

# app/controllers/application_controller.rb

##
# Main application controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Includes
  include Response
end
