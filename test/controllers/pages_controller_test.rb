require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  
  test "should get index" do
    get pages_index_url
    assert_response :success
    assert_select 'div#map'
    assert_select 'div#testConsole'
  end

end
