require 'test_helper'

class ScoreboardControllerTest < ActionController::TestCase
  test "should get live" do
    get :live
    assert_response :success
  end

end
