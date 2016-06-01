OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1011932408856740', '050a607b7293128c7da5d03d5d907cfc'
end
