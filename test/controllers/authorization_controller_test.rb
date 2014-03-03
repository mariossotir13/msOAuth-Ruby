require 'test_helper'

class AuthorizationControllerTest < ActionController::TestCase
  test "should get authorization_code" do
    get :authorization_code
    assert_response :success
  end

end
