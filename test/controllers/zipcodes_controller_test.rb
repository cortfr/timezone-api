require 'test_helper'

class ZipcodesControllerTest < ActionDispatch::IntegrationTest

  test "should return 200, zipcode" do
    post zipcodes_find_url, params: { zipcode: 97701 }
    assert_response :success
  end

  test "should return 404" do
    post zipcodes_find_url, params: { zipcode: 99999 }
    assert_equal 404, status
  end

  test "should return 400" do
    post zipcodes_find_url, params: { derp: true }
    assert_equal 400, status
  end

end
