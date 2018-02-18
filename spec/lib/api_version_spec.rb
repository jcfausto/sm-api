# spec/lib/api_version_spec.rb
require 'rails_helper'

RSpec.describe ApiVersion do
  subject { ApiVersion.new(DEFAULT_API_VERSION, true) }

  describe "#initialize" do
    it "should initialize version with DEFAULT_API_VERSION" do
      expect(subject.version).to eq(DEFAULT_API_VERSION)
    end

    it "should initialize default as true" do
      expect(subject.default).to be_truthy
    end
  end

  describe "#matches?" do
    let(:request) do
      req = Object.new
      def req.headers
        {accept: "application/vnd.messages.v2+json"}
      end
      return req
    end

    it "matches DEFAULT_API_VERSION as the default version" do
      expect(subject.matches?(request)).to be_truthy
    end
  end
end
