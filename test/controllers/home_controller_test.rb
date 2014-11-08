require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get pals" do
    get :pals
    assert_response :success
  end

end
