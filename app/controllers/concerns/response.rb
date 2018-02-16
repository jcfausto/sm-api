# app/controllers/concerns/response.rb

# A little helper for simplifying json response generation.
# It responds with 200 by default
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
