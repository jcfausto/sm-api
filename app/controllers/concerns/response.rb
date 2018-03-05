# frozen_string_literal: true

# app/controllers/concerns/response.rb

##
# A little helper for simplifying json response generation.
# It responds with 200 by default
module Response
  class ResponseMessages
    def self.created_successfully
      'created successfuly'.freeze
    end

    def self.unprocessable_entity
      'Unable to process'.freeze
    end

    def self.unauthorized
      'Unauthorized request'.freeze
    end
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
