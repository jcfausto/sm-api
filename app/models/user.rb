# frozen_string_literal: true

# app/controllers/users_controller.rb

class User < ApplicationRecord
  has_secure_password

  PASSWORD_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])/

  # validations
  validates_presence_of :username, :email, :password_digest, on: :create
  validates_length_of :password, minimum: 6
  # validates :password, format: { with: PASSWORD_FORMAT }
end
