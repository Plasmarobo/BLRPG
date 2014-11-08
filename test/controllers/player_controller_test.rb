require 'test_helper'

class PlayerControllerTest < ActionController::TestCase
  test "should get characters" do
    get :characters
    assert_response :success
  end

  test "should get sheet" do
    get :sheet
    assert_response :success
  end

end
