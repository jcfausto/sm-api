# spec/factories/message.rb
FactoryBot.define do
	factory :message do
		body { Faker::Lorem::sentence(word_count=280) }
		latitude { Faker::Address::latitude }
		longitude { Faker::Address::longitude }
	end
end