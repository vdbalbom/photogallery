require 'test_helper'

class GalleryControllerTest < ActionDispatch::IntegrationTest
  test "should get all_photos" do
    get gallery_all_photos_url
    assert_response :success
  end

  test "should get contributor_photos" do
    get gallery_contributor_photos_url
    assert_response :success
  end

  test "should get tag_photos" do
    get gallery_tag_photos_url
    assert_response :success
  end

  test "should get contributor_tag_photos" do
    get gallery_contributor_tag_photos_url
    assert_response :success
  end

end
