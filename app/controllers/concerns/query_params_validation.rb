# app/controllers/concerns/query_params_validation.rb
module QueryParamsValidation
	VALID_LATITUDE = {min: -90, max: 90}
	VALID_LONGITUDE = {min: -180, max: 180}

	def valid_params?(params)
		# if params is not defined then is not possible to validate and the most secure approach is to 
		# assume that is not valid
		if params
			[:type, :latitude, :longitude].all? { |e| params.include?(e) }
		end
	end

	def valid_type?(params)
		# if params is not defined then is not possible to validate and the most secure approach is to 
		# assume that is not valid
		if params
			["nearby", "nearest"].include?(params[:type])
		end
	end

	def valid_location?(params)
		# if params is not defined then is not possible to validate and the most secure approach is to 
		# assume that is not valid
		# I am using Float(e) to assure that a blank string will be also invalid. to_f will turn a blank string
		# into 0.0 which is a valid latitude and longitude, but not valid for the application because it was
		# not a result of an explicit and correctly informed query param.
		if params
			[params[:latitude], params[:longitude]].all? { |e| Float(e) rescue false } &&
				params[:latitude].to_f.between?(VALID_LATITUDE[:min], VALID_LATITUDE[:max]) &&
				params[:longitude].to_f.between?(VALID_LONGITUDE[:min], VALID_LONGITUDE[:max])
		end
	end

	def valid_radius?(params)
		# if params is not defined then is not possible to validate and the most secure approach is to 
		# assume that is not valid
		if params
			if params.include?(:radius)
				((Float(params[:radius]) rescue false) && params[:radius].to_f.is_a?(Numeric))
			end
		else
			false
		end
	end
end