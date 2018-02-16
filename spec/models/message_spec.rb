# spec/models/message_spec.rb
require 'rails_helper'

RSpec.describe Message, type: :model do
	subject { create(:message) }
	
	# Validations
	describe "validations" do
		describe "presence" do
			it { should validate_presence_of(:content) }
			it { should validate_presence_of(:latitude) }
			it { should validate_presence_of(:longitude) }
		end

		describe "content lenght" do
			context "lenght is valid" do
				it "creates the message" do
					expect(subject)
				end
			end

			context "when length is invalid" do
				subject { described_class.create(content: Faker::Lorem::sentence(word_count=100), latitude: 1, longitude: 1) }

				it "does not create the message" do
					expect(subject.valid?).to be_falsey
				end
			end

		end
	end
end