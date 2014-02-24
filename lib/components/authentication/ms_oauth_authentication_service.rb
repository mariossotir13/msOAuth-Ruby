require 'components/authentication/ms_oauth_client_id_generator'
require 'components/authentication/ms_oauth_password_generator'
require 'components/authentication/ms_oauth_cipher_generator'

class MsOauthAuthenticationService

  def initialize
    @cipherGen = MsOauthCipherGenerator.new
  end

  def create_client_id(client)
    MsOauthClientIdGenerator.generate client
  end

  def create_password
    MsOauthPasswordGenerator.create_password
  end

  def decrypt_password(password, key)
    @cipherGen.decrypt password, key
  end

  def encrypt_password(password, key)
    @cipherGen.encrypt password, key
  end
end