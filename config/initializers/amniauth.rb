Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.client_id, Rails.application.secrets.client_secret
end
