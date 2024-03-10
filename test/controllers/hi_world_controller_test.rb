require "test_helper"

class HiWorldControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hi_world_index_url
    assert_response :success
  end
end
