# spec/models/message_spec.rb
require 'rails_helper'

RSpec.describe Message, type: :model do
	subject { create(:message) }
	
	# Validations
	describe "validations" do
		it { should validate_presence_of(:content) }
		it { should validate_presence_of(:latitude) }
		it { should validate_presence_of(:longitude) }
	end
end