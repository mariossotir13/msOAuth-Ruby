class MsOauthAuthorizationService

  def create_access_token
    create_authorization_code
  end

  def create_authorization_code
    SecureRandom.urlsafe_base64(32).chomp('=')
  end
end