# spec/requests/health_check_spec.rb
require 'rails_helper'

RSpec.describe HealthCheck, type: :request do
  before { get '/healthcheck' }

  it "should be healty" do
    expect(response).to have_http_status(:ok)
  end
end
