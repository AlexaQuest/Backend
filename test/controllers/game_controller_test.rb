require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get get" do
    get game_get_url
    assert_response :success
  end

  test "should get post" do
    get game_post_url
    assert_response :success
  end

end
