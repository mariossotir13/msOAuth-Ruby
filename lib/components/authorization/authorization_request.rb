class AuthorizationRequest
  include ActiveModel::Validations

  validates :client_id, :redirection_uri, :response_type, :state, presence: true
  validates :scopes, length: { minimum: 1, message: 'Please, specify at least one scope.' }
  validate :valid_client?

  QUERY_PARAM = 'authz_rq'
  SERVER_URI = 'http://msoauthruby.local/oauth2/c/authorization'

  attr_accessor :client_id, :redirection_uri, :response_type, :state
  attr_reader :oauth_server_uri, :scopes

  # @param [ActionDispatch::Request] request
  # @return [AuthorizationRequest]
  def self.from_request(request)
    auth_request = self.new SERVER_URI
    auth_request.client_id = request.query_parameters[CLIENT_ID]
    auth_request.redirection_uri = request.query_parameters[REDIRECTION_URI]
    auth_request.response_type = request.query_parameters[RESPONSE_TYPE]
    auth_request.set_scopes request.query_parameters[SCOPE]
    auth_request.state = request.query_parameters[STATE]
    auth_request
  end

  # @param [String] uri
  # @return [AuthorizationRequest]
  def self.from_uri(uri)
    uri_ary = URI.decode_www_form( URI.decode_www_form_component(uri) )
    uri_hash = uri_ary.reduce({}) { |hash, pair| hash[pair.first] = pair.last; hash }

    request = self.new SERVER_URI
    request.client_id = uri_hash[CLIENT_ID]
    request.redirection_uri = uri_hash[REDIRECTION_URI]
    request.response_type = uri_hash[RESPONSE_TYPE]
    request.set_scopes uri_hash[SCOPE]
    request.state = uri_hash[STATE]
    request
  end

  # @param [String] server_uri
  def initialize(server_uri)
    @oauth_server_uri = server_uri
    @client_id = ''
    @redirection_uri = ''
    @response_type = nil
    @scopes = Array.new
    @state = ''
  end

  # @param [AuthorizationCodeScope] scope
  def add_scope(scope)
    @scopes.push scope
  end

  # @param [String] scopes
  def set_scopes(scopes)
    @scopes = scopes.blank? ? Array.new : scopes.split(' ')
  end

  def to_query_string_param_value
    URI.encode_www_form_component(URI.encode_www_form([
        %W(#{CLIENT_ID} #{@client_id}),
        %W(#{REDIRECTION_URI} #{@redirection_uri}),
        %W(#{STATE} #{@state}),
        %W(#{RESPONSE_TYPE} #{@response_type}),
        %W(#{SCOPE} #{@scopes.join(' ')})
    ]))
  end

  # @return [Boolean]
  def valid_client?
    errors.add(:client_id, 'Please, provide a valid Client.') unless @client_id.present? \
      && Client.find(@client_id).present?
  end

  private

  CLIENT_ID = 'client_id'
  REDIRECTION_URI = 'redirect_uri'
  RESPONSE_TYPE = 'response_type'
  SCOPE = 'scope'
  STATE = 'state'
end