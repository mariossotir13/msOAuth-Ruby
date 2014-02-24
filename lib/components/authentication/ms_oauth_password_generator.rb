class MsOauthPasswordGenerator

  def self.create_password
    SecureRandom.urlsafe_base64 20
  end
end