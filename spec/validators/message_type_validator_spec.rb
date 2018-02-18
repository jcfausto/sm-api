# spec/validators/message_type_validator_spec.rb
require 'rails_helper'

RSpec.describe MessageTypeValidator do
  let(:valid_type) { VALID_MESSAGE_TYPES[:nearby] }
  let(:invalid_type) { "all" }
  subject { described_class.new( { type: valid_type } ) }

  describe "#initialize" do
    context "when valid params" do
      it "should initialize type" do
        expect(subject.type).to eq(:nearby)
      end
    end

    context "when params is missing" do
      subject { described_class.new(nil) }

      it "should initialize without errors" do
        expect(subject)
      end

      it "should initialize type as nil" do
        expect(subject.type).to be_nil
      end
    end
  end

  describe "#valid?" do
    context "when type is valid" do
      it "should return true" do
        expect(subject.valid?).to be_truthy
      end
    end

    context "when type is invalid" do
      let(:valid_type) { invalid_type }
      it "should return false" do
        expect(subject.valid?).to be_falsy
      end
    end
  end
end
