# spec/validators/location_validator.rb
require 'rails_helper'

RSpec.describe LocationValidator do
  let(:valid_latidude) { 1 }
  let(:not_a_number) { "foo" }
  let(:negative) { -1.0 }
  let(:latitude_out_of_range) { 90.000001 }
  let(:valid_longitude) { 2 }
  let(:longitude_out_of_range) { 180.000001 }
  let(:valid_radius) { 50.0 }
  let(:invalid_radius) { 200.0 }
  let(:valid_params) { { latitude: valid_latidude, longitude: valid_longitude, radius: valid_radius } }
  let(:params_without_radius) { { latitude: valid_latidude, longitude: valid_longitude } }
  subject { described_class.new(valid_params) }

  describe "#initialize" do
    context "when valid params" do
      it "should initialize latitude" do
        expect(subject.latitude).to eq(valid_latidude)
      end

      it "should initialize longitude" do
        expect(subject.longitude).to eq(valid_longitude)
      end

      it "should initialize radius" do
        expect(subject.radius).to eq(valid_radius)
      end
    end

    context "when params is missing" do
      subject { described_class.new(nil) }
      it "should initialize without errors" do
        expect(subject)
      end

      it "should initialize location attributes as nil" do
        expect(subject.latitude).to be_nil
        expect(subject.longitude).to be_nil
        expect(subject.radius).to be_nil
      end
    end
  end

  describe "#valid?" do
    context "when params are invalid" do
      context "when latitude is not a number" do
        let(:valid_latidude) { not_a_number }
        it "should return false" do
          expect(subject.valid?).to be_falsy
        end
      end

      context "when latitude is out of range" do
        let(:valid_latidude) { latitude_out_of_range }
        it "should return false" do
          expect(subject.valid?).to be_falsy
        end
      end


      context "when latitude is not a number" do
        let(:valid_latidude) { not_a_number }
        it "should return false" do
          expect(subject.valid?).to be_falsy
        end
      end

      context "when longitude is out out of range" do
        let(:valid_longitude) { longitude_out_of_range }
        it "should return false" do
          expect(subject.valid?).to be_falsy
        end
      end

      context "when longitude is not a number" do
        let(:valid_longitude) { not_a_number }
        it "should return false" do
          expect(subject.valid?).to be_falsy
        end
      end

      context "when radius is greater than the system default" do
        let(:valid_radius) { invalid_radius }
        it "should return false" do
          expect(subject.valid?).to be_falsy
        end
      end

      context "when radius is not a number" do
        let(:valid_radius) { not_a_number }
        it "should return false" do
          expect(subject.valid?).to be_falsy
        end
      end

      context "when radius is negative" do
        let(:valid_radius) { negative }
        it "should return false" do
          expect(subject.valid?).to be_falsy
        end
      end

    end

    describe "when params are valid" do
      context "when radius is not in params" do
        subject { described_class.new(params_without_radius) }
        it "should return true" do
          expect(subject.valid?).to be_truthy
        end
      end

      context "when radius is in params" do
        it "should return true" do
          expect(subject.valid?).to be_truthy
        end

        it "should keep the informed radius" do
          expect(subject.radius).to be(valid_radius)
        end
      end

    end
  end
end
