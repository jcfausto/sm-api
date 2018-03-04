# frozen_string_literal: true

# app/controllers/messages_controller.rb

module V1
  ##
  # This controller is responsible for actions related to the :message resource
  class MessagesController < ApplicationController
    ##
    # POST /messages
    # Creates a new message
    def create
      message = Message.create!(message_params)
      json_response(message, :created)
    rescue StandardError => error
      json_response({ message: error.message }, :unprocessable_entity)
    end

    ##
    # GET /messages
    def index
      result = MessageSearchService.new(params).call
      json_response({ result: result.data }, result.status)
    end

    private

    # Params sanitization
    def message_params
      params.require(:message).permit(:content, :latitude, :longitude)
    end
  end
end
