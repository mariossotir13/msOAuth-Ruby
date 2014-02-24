class MsOauthClientIdGenerator

  def self.generate(client)
    info = "#{client.client_type}#{client.redirection_uri}#{client.app_title}#{client.email}"
    hash = Digest::SHA2.digest info
    hash = Base64.urlsafe_encode64 hash.to_s
    hash.gsub '=', ''
  end
end