# spec/models/message_spec.rb
require 'rails_helper'

RSpec.describe Message, type: :model do
	# Validations
	it { should validate_presence_of(:content) }
	it { should validate_presence_of(:latitude) }
	it { should validate_presence_of(:longitude) }
end