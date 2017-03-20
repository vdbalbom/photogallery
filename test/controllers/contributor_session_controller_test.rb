require 'test_helper'

class ContributorSessionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contributor_session_new_url
    assert_response :success
  end

end
