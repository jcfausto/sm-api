# spec/validators/search_filter_validator_spec.rb
require 'rails_helper'

RSpec.describe SearchFilterValidator do
  let(:valid_type) { VALID_MESSAGE_TYPES[:nearby] }
  let(:invalid_type) { "any" }
  let(:valid_latitude) { VALID_LATITUDE[:max] }
  let(:valid_longitide) { VALID_LONGITUDE[:max] }
  let(:valid_params) { {type: valid_type, latitude: valid_latitude, longitude: valid_longitide } }
  subject { described_class.new(valid_params) }

  describe "#initialize" do
    it "should initialize location" do
      expect(subject.location).not_to be_nil
    end

    it "should initialize type" do
      expect(subject.message_type).not_to be_nil
    end
  end

  describe "#valid?" do
    context "when params are valid" do
      it "is valid" do
        expect(subject.valid?).to be_truthy
        expect(subject.error_messages.size).to eq(0)
      end
    end

    context "when params are invalid" do
      let(:valid_type) { invalid_type }
      it "is invalid" do
        expect(subject.valid?).to be_falsy
        expect(subject.error_messages.size).to eq(1)
      end
    end
  end
end
