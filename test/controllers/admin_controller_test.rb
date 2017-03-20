require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get settings" do
    get admin_settings_url
    assert_response :success
  end

  test "should get change_password" do
    get admin_change_password_url
    assert_response :success
  end

end
