# spec/factories/message.rb
FactoryBot.define do
	factory :message do
		content { Faker::Lorem::sentence(word_count=5, char_count=100) }
		latitude { Faker::Address::latitude }
		longitude { Faker::Address::longitude }
	end
end