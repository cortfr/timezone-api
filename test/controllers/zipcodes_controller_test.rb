require 'test_helper'

class ZipcodesControllerTest < ActionDispatch::IntegrationTest
  test "should get find" do
    get zipcodes_find_url
    assert_response :success
  end

end
