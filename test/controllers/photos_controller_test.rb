require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  # test "should get show" do
  #   get show_photo_path(photos(:one).id)
  #   assert_response :success
  # end

  test "should get edit" do
    get edit_photo_path(photos(:one).id)
    assert_response :success
  end

  test "should get new" do
    get upload_photo_path
    assert_response :success
  end

end
