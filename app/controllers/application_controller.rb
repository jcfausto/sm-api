# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	# Includes
  include Response
end
