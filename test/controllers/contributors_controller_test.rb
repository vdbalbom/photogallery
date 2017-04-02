require 'test_helper'

class ContributorsControllerTest < ActionDispatch::IntegrationTest
  test "should get settings" do
    get contributor_settings_url
    assert_response :success
  end

  test "should get change_password" do
    get contributor_change_password_url
    assert_response :success
  end

  test "should get new" do
    get admin_add_contributor_url
    assert_response :success
  end

  test "should get remove" do
    get remove_contributor_path(contributors(:one).id)
    assert_response :success
  end

end
