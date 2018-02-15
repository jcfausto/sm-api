# spec/requests/messages_spec.rb
require 'rails_helper'

RSpec.describe "Message API", type: :request do
	# Message type: Nearest
	let(:nearest_type) { "type='nearest'" }
	# Message type: Nearby
	let(:nearby_type) { "type='nearby'" }
	# Invalid type
	let(:invalid_type) { "type='any'"}
	# Specific radius
	let(:specific_radius) { 20 }
	# Valid latitude
	let(:valid_latitude) { 52.54124 }
	# Valid longitude
	let(:valid_longitude) { 13.400241 }
	# Invalid latitude
	let(:invalid_latitude) { -90.000001 }
	# Invalid longitude 
	let(:invalid_longitude) { 180.000001 }

	# POST /messages
	describe "POST /messages" do
		context "when request is valid" do
			it "creates the message" do
				expect(response).to have_http_status(:created)
			end
		end

		context "when request is invalid" do
			context "when content is not defined" do
				it "does not create the message" do
					expect(response).to have_http_status(:unprocessable_entity)
				end
			end

			context "when latitude is not defined" do
				it "does not create the message" do
					expect(response).to have_http_status(:unprocessable_entity)
				end
			end

			context "when longitude is not defined" do
				it "does not create the message" do
					expect(response).to have_http_status(:unprocessable_entity)
				end
			end

			context "when latitude is invalid" do
				it "does not create the message" do
					expect(response).to have_http_status(:unprocessable_entity)
				end	
			end
			
			context "when longitude is invalid" do
				it "does not create the message" do
					expect(response).to have_http_status(:unprocessable_entity)
				end
			end
		end
	end


	# GET /messages
	describe "GET /messages" do
		before { get "/messages#{query_string}" }

		context "when no type is defined" do
			let(:query_string) { "" }
			it "should return a bad request message" do
				expect(response).to have_http_status(:bad_request)
			end
		end

		context "when an invalid type is defined" do
			let(:query_string) { "?#{invalid_type}" }

			it "should return a bad request message" do
				expect(response).to have_http_status(:bad_request)
			end
		end

		context "when location is undefined" do
			context "when only latitude is defined" do
				let(:query_string) { "?#{nearby_type}&latitude=#{valid_latitude}&longitude=" }

				it "should return a bad request message" do
					expect(response).to have_http_status(:bad_request)
				end
			end

			context "when only longitude is defined" do
				let(:query_string) { "?#{nearby_type}&latitude=&longitude=#{valid_longitude}" }
	
				it "should return a bad request message" do
					expect(response).to have_http_status(:bad_request)
				end
			end

			context "when latitude is invalid" do
				let(:query_string) { "?#{nearby_type}&latitude=#{invalid_latitude}&longitude=#{valid_longitude}" }
	
				it "should return a bad request message" do
					expect(response).to have_http_status(:bad_request)
				end			
			end

			context "when longitude is invalid" do
				let(:query_string) { "?#{nearby_type}&latitude=#{valid_latitude}&longitude=#{invalid_longitude}" }
				
				it "should return a bad request message" do
					expect(response).to have_http_status(:bad_request)
				end
			end
		end

		context "when type is valid" do
			context "when requesting nearby messages" do
				context "with a specific radius" do
					let(:query_string) { "?#{nearby_type}&latitude=#{valid_latitude}&longitude=#{valid_longitude}&radius=#{specific_radius}" }

					it "returns only messages within the radius" do
						#expect(JSON.parse(response.body)['messages']).not_to include(out_of_range_message)
					end
				end
			
				context "without a specific radius" do
					let(:query_string) { "?#{nearby_type}&latitude=#{valid_latitude}&longitude=#{valid_longitude}" }

				  it "returns only messages within the default range" do
						#expect(JSON.parse(response.body)['messages']).not_to include(out_of_range_message)
						#expect(JSON.parse(response.body)['messages']).not_to include(in_range_message)
					end
				end
			end

			context "when requesting the nearest message" do
				let(:query_string) { "?#{nearest_type}&latitude=#{valid_latitude}&longitude=#{valid_longitude}" }
				
				it "returns the nearest message" do
					expect(response).to have_http_status(:ok)
				end
				
			end
		end	
	end
end