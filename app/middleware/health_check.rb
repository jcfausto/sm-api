# app/lib/middlewares/healthcheck.rb

##
# This class implements a middlware for checking if
# the application is responding to requests.
class HealthCheck
  PAYLOAD = ['{"status": "ok"}'].freeze
  HEADER = { 'Content-Type' => 'application/json' }

  def initialize(app)
    @app = app
  end

  # To assure thread safety, every call will be performed
  # on a duplicated object assuring that the instance variables
  # remains isolated per thread.
  def call(env)
    dup.__call(env)
  end

  # Any instance variable assigned here will be thread-safe.
  def __call(env)
    if env['REQUEST_URI'] == '/healthcheck'.freeze
      [200, HEADER, PAYLOAD]
    else
      @app.call(env)
    end
  end
end
