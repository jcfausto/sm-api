# spec/validators/search_radius_validator_spec.rb
require 'rails_helper'

RSpec.describe SearchRadiusValidator do
  let(:valid_radius) { 50.0 }
  let(:invalid_radius) { 200.0 }
  let(:not_a_number) { "foo" }
  let(:negative) { -1.0 }
  let(:params) { { radius: valid_radius } }
  subject { described_class.new(params) }

  describe '#initialize'do
    it 'should initialize with radius' do
      expect(subject.radius.to_f).to be(params[:radius])
    end
  end

  describe '#valid'do
    context "when radius is greater than the system default" do
      let(:valid_radius) { invalid_radius }
      it "should return false" do
        expect(subject.valid?).to be_falsy
      end

      it "should return invalid radius message" do
        subject.valid?
        expect(subject.error_messages[0]).to eq(ValidationMessages.invalid_radius)
      end
    end

    context "when radius is not a number" do
      let(:valid_radius) { not_a_number }
      it "should return false" do
        expect(subject.valid?).to be_falsy
      end

      it "should return invalid radius message" do
        subject.valid?
        expect(subject.error_messages[0]).to eq(ValidationMessages.invalid_radius)
      end
    end

    context "when radius is negative" do
      let(:valid_radius) { negative }
      it "should return false" do
        expect(subject.valid?).to be_falsy
      end

      it "should return invalid radius message" do
        subject.valid?
        expect(subject.error_messages[0]).to eq(ValidationMessages.invalid_radius)
      end
    end

    context "when radius is valid" do
      let(:valid_radius) { 50.0 }
      it "should be valid" do
        expect(subject.valid?).to be_truthy
      end
    end
  end
end
