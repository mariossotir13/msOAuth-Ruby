require 'components/authorization/authorization_error'

class ValidationResponse

  attr_reader :error, :error_message, :error_map

  # @param [Hash] violations
  # @param [Hash] error_map
  def initialize(violations, error_map)
    @error_map = error_map
    @valid = true
    set_error violations
  end

  def valid?
    @valid
  end


  protected

  # @param [Hash] violations
  def set_error(violations)
    if violations.empty?
      return
    end

    property = violations.has_key?(:redirection_uri) ? :redirection_uri : violations.first[0]
    @error = @error_map.has_key?(property) ? @error_map[property] : AuthorizationError::INVALID_REQUEST
    @error_message = violations[property]
    @valid = false
  end
end