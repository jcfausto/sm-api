# frozen_string_literal: true

# spec/requests/user_specs.rb
require 'rails_helper'

RSpec.describe 'User', type: :request do
  let(:password) { Faker::Internet.password }
  let(:valid_params) { { user: { username: Faker::Internet.user_name, password: password, password_confirmation: password } } }
  let(:header) { { accept: 'application/vnd.messages.v1+json' } }

  describe 'POST /user/signup' do
    before { post '/user/signup', headers: header, params: valid_params }

    it 'should signup the new user' do
      puts JSON.parse(response.body)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'POST /user/login' do

  end

end
