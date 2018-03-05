# frozen_string_literal: true

# app/lib/json_web_token.rb

##
# This class is responsible for encoding and decoding JWTs
class JsonWebToken
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload)
    payload[:exp] = 24.hours.from_now
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    HashWithIndifferentAccess.new JWT.decode(token, HMAC_SECRET)[0]
  rescue JWT::VerificationError => error
    raise(StandardError, "Invalid Token: #{error.message}")
  end
end
