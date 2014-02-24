require '../../../app/models/client'

class AuthorizationRequest
  QUERY_PARAM = 'authz_rq'
  SERVER_URI = 'http://msoauthruby.local/oauth2/c/authorization'

  attr_accessor :client_id, :redirection_uri, :response_type, :state
  attr_reader :oauth_server_uri, :scopes
  attr_writer :client

  @client = nil
  @client_id = ''
  @redirection_uri = ''
  @response_type = nil
  @scopes = Array.new
  @state = ''

  # @param [String] server_uri
  def initialize(server_uri)
    @oauth_server_uri = server_uri
  end

  # @param [AuthorizationCodeScope] scope
  def add_scope(scope)
    @scopes.push scope
  end

  # @return [Boolean]
  def is_client_id_valid?
    !@client_id.empty? && @client.find(@client_id) != nil
  end

  private

  CLIENT_ID = 'client_id'
  REDIRECTION_URI = 'redirect_uri'
  RESPONSE_TYPE = 'response_type'
  SCOPE = 'scope'
  STATE = 'state'
end