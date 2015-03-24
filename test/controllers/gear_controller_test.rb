require 'test_helper'

class GearControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get _card" do
    get :_card
    assert_response :success
  end

  test "should get _instance_list" do
    get :_instance_list
    assert_response :success
  end

  test "should get _instance_row" do
    get :_instance_row
    assert_response :success
  end

  test "should get _template_list" do
    get :_template_list
    assert_response :success
  end

  test "should get _template_row" do
    get :_template_row
    assert_response :success
  end

end
