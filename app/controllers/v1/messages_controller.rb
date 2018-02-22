# app/controllers/messages_controller.rb

##
# This controller is responsible for actions related to the :message resource
module V1
	class MessagesController < ApplicationController
		attr_reader :search_filter

		# before callbacks
		before_action :set_search_params, only: [:index]

		# Consts
		ORDER_BY_DISTANCE = "distance".freeze

		##
		# POST /messages
		# Creates a new message
		def create
			@message = Message.create!(message_params)
			json_response(@message, :created)
		rescue StandardError => error
			json_response({ message: error.message }, :unprocessable_entity)
		end

		##
		# GET /messages
		# Fetch messages based on a search filter
		# The search filter should be valid, otherwise a bad_request will be returned
		def index

			if search_filter.valid?
				location = search_filter.location

				# if the radius is not defined, then set it to the
				# maximum allowed by default.
				radius = MAXIMUM_SEARCH_RADIUS_IN_KM
				radius = location.radius if location.radius

				messages = Message.near(
					[location.latitude, location.longitude],
					radius, :units => :km,
					:order => ORDER_BY_DISTANCE
				)

				if search_filter.message_type.type == :nearest
					messages = messages.first
				end

				# return a response in JSON format and with status :ok
				json_response({result: messages})
			else
				json_response({result:  search_filter.error_messages}, :bad_request)
			end
		end

		private

		def set_search_params
			@search_filter = SearchFilterValidator.new(params)
		end

		# Params sanitization
		def message_params
			params.require(:message).permit(:content, :latitude, :longitude)
		end
	end
end
