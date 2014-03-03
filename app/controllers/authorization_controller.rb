require 'components/authorization/authorization_request'
require 'components/authorization/validation_response'
require 'components/authorization/authorization_error_response'
require 'components/authorization/ms_oauth_authorization_service'
require 'components/authorization/authorization_response'

class AuthorizationController < ApplicationController

  PARAM_AUTHORIZATION_REQUEST_ACCEPT = 'authz_rq_accept'

  def initialize
    @authorization_service = MsOauthAuthorizationService.new
  end

  def access_denied
    auth_request = create_authorization_request

    response = AuthorizationErrorResponse.new AuthorizationError::ACCESS_DENIED
    response.error_description = 'The owner denied access to her resources'
    response.state = auth_request.state

    redirect_to auth_request.redirection_uri + '?' + response.to_query_string
  end

  def authorization_code
    auth_request = create_authorization_request
    unless auth_request.valid?
      validation_response = ValidationResponse.new \
        auth_request.errors.messages,
        {
            client_id: AuthorizationError::INVALID_CLIENT,
            redirection_uri: AuthorizationError::REDIRECTION_URI,
            response_type: AuthorizationError::UNSUPPORTED_RESPONSE_TYPE,
            scopes: AuthorizationError::INVALID_SCOPE
        }

      return invalid_authorization_request validation_response, auth_request
    end

    unless authorization_request_accepted?
      return redirect_to(ms_oauth_authorization_acceptance_url + '?' + AuthorizationRequest::QUERY_PARAM + '=' + auth_request.to_query_string_param_value)
    end

    code = create_authorization_code auth_request
    response = AuthorizationResponse.new auth_request.redirection_uri, code
    response.state = auth_request.state

    redirect_to response.to_uri
  end

  def resource_owner_acceptance
    auth_request = create_authorization_request

    @client = Client.find auth_request.client_id
    @scopes = get_scopes_from_request auth_request
    @authz_rq = auth_request
  end


  protected

  # @return [Boolean]
  def authorization_request_accepted?
    request.query_parameters.has_key?(PARAM_AUTHORIZATION_REQUEST_ACCEPT) \
      && request.query_parameters[PARAM_AUTHORIZATION_REQUEST_ACCEPT] == '1'
  end

  # @param [AuthorizationRequest] auth_request
  # @return [String]
  def create_authorization_code(auth_request)
    code = @authorization_service.create_authorization_code

    expiration_date = Time.zone.now + MsOAuthRuby::Application.config.ms_oauth_code_grant_expires_in
    profile = AuthorizationCodeProfile.new
    profile.authorization_code = code
    profile.client = Client.find auth_request.client_id
    profile.expiration_date = expiration_date
    profile.redirection_uri = auth_request.redirection_uri
    # TODO: Retrieve resource owner via the Devise mechanism.
    profile.resource_owner = ResourceOwner.first
    profile.response_type = auth_request.response_type
    profile.state = auth_request.state
    profile.authorization_code_scopes = get_scopes_from_request auth_request
    profile.save

    code
  end

  # @return [AuthorizationRequest]
  def create_authorization_request
    request.query_parameters.has_key?(AuthorizationRequest::QUERY_PARAM) \
      ? AuthorizationRequest::from_uri(request.query_parameters[AuthorizationRequest::QUERY_PARAM])
      : AuthorizationRequest::from_request(request)
  end

  # @param [AuthorizationRequest] request
  def get_scopes_from_request(request)
    requestScopes = request.scopes
    requestScopes.map { |title| AuthorizationCodeScope.find_by_title title }.compact
  end

  # @param [AuthorizationRequest] auth_request
  def invalid_authorization_request(validation_response, auth_request)
    response = AuthorizationErrorResponse.new validation_response.error
    response.error_description = validation_response.error_message
    response.state = auth_request.state
    unless response.redirected?
      @error_description = response.error + ': ' + response.error_description.first

      return render template: 'authorization/invalid_request_page'
    end

    redirect_to auth_request.redirection_uri + '?' + response.to_query_string
  end
end
