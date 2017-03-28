require 'test_helper'

class AdminSessionControllerTest < ActionDispatch::IntegrationTest
  test "should get admin_login" do
    get admin_url
    assert_response :success
  end

end
