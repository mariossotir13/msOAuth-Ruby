class AuthorizationErrorResponse

  attr_reader :error
  attr_accessor :error_description, :error_uri, :state

  def initialize(error)
    @error_description = ''
    @error_uri = ''
    @state = ''
    set_error error
  end

  def redirected?
    @redirected
  end

  def to_query_string
    URI.encode_www_form [%W[#{ERROR} #{@error}], %W[#{ERROR_DESCRIPTION} #{@error_description}], %W[#{STATE} #{@state}]]
  end


  protected

  def set_error(error)
    @error = error
    @redirected = error != AuthorizationError::REDIRECTION_URI
  end

  private

  ERROR = 'error'
  ERROR_DESCRIPTION = 'error_description'
  ERROR_URI = 'error_uri'
  STATE = 'state'
end