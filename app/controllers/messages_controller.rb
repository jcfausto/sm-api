# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
	attr_reader :type, :longitude, :latitude

	# before callbacks
	before_action :check_query_params, only: [:index]
	before_action :set_search_params, only: [:index]

	# POST /messages
	def create
		@message = Message.create!(message_params)
		json_response(@message, :created)
	rescue StandardError => e 
		json_response({ message: e.message }, :unprocessable_entity)
	end

	# GET /messages
	def index
		# all validations will happen before, so if the execution reached this point
		# the parameters meet all the requirements and the query can be done.
		if type == "nearby"
			result = Message.all
		elsif type == "nearest"
			result = Message.all
		end
	
		# return a response in JSON format and with status :ok
		json_response({messages: result})
	end

	private

	def check_query_params
		validation_message = []

		# Query string must have type, latitude and longitude parameters
		validation_message.push("Invalid query params") unless valid_params?(params) 
		
		# Only nearby and nearest searches are supported at the moment.
		# TODO: What if I want to support a new type of search??	
		validation_message.push("Unsupported message type") unless valid_type?(params)
		
		# Provided location must have valid latitude and longitude.
		validation_message.push("Invalid location") unless valid_location?(params)
		
		# Although optional, the search radius can be defined via a query param. 
		# If defined, this one will be used for searching nearby messages. 
		# This param only applies to the nearby search* type.
		validation_message.push("Invalid radius") unless valid_radius?(params)
		
		if !validation_message.empty?
			json_response({message:  validation_message}, :bad_request)
		end
	end

	def set_search_params
		@type = params[:type]
		# At this point, check_query_params was already executed and is certain that to_f will not fail
		@latitude = params[:latitude].to_f
		@longitude = params[:longitude].to_f
	end

	# Params sanitization
	def message_params
		params.require(:message).permit(:content, :latitude, :longitude)
	end
end