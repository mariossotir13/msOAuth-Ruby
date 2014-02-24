require 'components/authentication/ms_oauth_authentication_service'

class RegistrationController < ApplicationController

  def initialize
    @authService = MsOauthAuthenticationService.new
  end

  def create_client
    @client = Client.new client_params
    @client.id = @authService.create_client_id @client

    client_secret = @authService.create_password
    encryption_key = MsOAuthRuby::Application.config.ms_oauth_encryption_key
    @client.password = @authService.encrypt_password client_secret, encryption_key

    if @client.save
      redirect_to client_url @client
    else
      render 'new_client'
    end
  end

  def new_client
    @client = Client.new
  end

  def show_client
    @client = Client.find params[:id]

    @client.password = @authService.decrypt_password @client.password,
                                                     MsOAuthRuby::Application.config.ms_oauth_encryption_key
  end

  private

  def client_params
    params.require(:client).permit(:app_title, :redirection_uri, :email, :client_type)
  end
end
