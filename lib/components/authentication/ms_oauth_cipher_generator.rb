class MsOauthCipherGenerator

  def initialize
    @cipher = OpenSSL::Cipher::AES128.new(:CBC)
    @iv_size = @cipher.random_iv.length
  end

  # @param [String] text
  # @param [String] key
  # @return [String]
  def decrypt(text, key)
    text = Base64.urlsafe_decode64 text
    iv = text[0...@iv_size]
    cipher_text = text[@iv_size...text.length]

    @cipher.reset
    @cipher.decrypt
    @cipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1 key, '', PBKDF2_ITER, PBKDF2_KEY_LEN
    @cipher.iv = iv
    @cipher.update(cipher_text) + @cipher.final
  end

  # @param [String] text
  # @param [String] key
  # @return [String]
  def encrypt(text, key)
    @cipher.reset
    @cipher.encrypt
    @cipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1 key, '', PBKDF2_ITER, PBKDF2_KEY_LEN
    iv = @cipher.random_iv
    cipher_text = iv + @cipher.update(text) + @cipher.final
    Base64.urlsafe_encode64 cipher_text
  end


  private

  PBKDF2_ITER = 10000
  PBKDF2_KEY_LEN = 16
end