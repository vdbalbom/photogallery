require 'test_helper'

class GalleryControllerTest < ActionDispatch::IntegrationTest
  test "should get all_photos" do
    get gallery_photos_url
    assert_response :success
  end

  test "should get contributor_photos" do
    get contributor_photos_url(contributors(:one).id)
    assert_response :success
  end

  test "should get tag_photos" do
    get tag_photos_url(tags(:one).id)
    assert_response :success
  end

  test "should get contributor_tag_photos" do
    get contributor_tag_photos_url(contributors(:one).id,tags(:one).id)
    assert_response :success
  end

end
