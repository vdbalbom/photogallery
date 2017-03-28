require 'test_helper'

class ContributorSessionControllerTest < ActionDispatch::IntegrationTest
  test "should get contributor_login" do
    get login_url
    assert_response :success
  end

end
