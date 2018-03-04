# spec/requests/application_controller_spec.rb
require 'rails_helper'

RSpec.describe ApplicationController, type: :request do
  describe "#unauthorized_route" do
    before { get '/' }
    it "should not authorize the request" do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
