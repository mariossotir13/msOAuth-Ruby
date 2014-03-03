class AuthorizationResponse

  attr_accessor :state
  attr_reader :oauth_code, :redirection_uri

  def initialize(redirection_uri, authorization_code)
    @redirection_uri = redirection_uri
    @oauth_code = authorization_code
  end

  # @return [String]
  def to_query_string
    URI.encode_www_form [%W[#{OAUTH_CODE} #{@oauth_code}], %W[#{STATE} #{state}]]
  end

  # @return [String]
  def to_uri
    @redirection_uri + '?' + to_query_string
  end

  private

    OAUTH_CODE = 'code'
    STATE = 'state'
end