require 'test_helper'

class ContributorControllerTest < ActionDispatch::IntegrationTest
  test "should get settings" do
    get contributor_settings_url
    assert_response :success
  end

  test "should get change_password" do
    get contributor_change_password_url
    assert_response :success
  end

end
