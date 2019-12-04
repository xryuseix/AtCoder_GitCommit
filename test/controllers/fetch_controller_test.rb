require 'test_helper'

class FetchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fetch_index_url
    assert_response :success
  end

end
