Rails.application.routes.draw do

	# This is the default API route. Unsupported versions will fallback to this one
	scope :api, module: :v1, constraints: ApiVersion.new(DEFAULT_API_VERSION, true) do
		resources :messages, only: [:create, :index]
	end
end
