require 'test_helper'

class ImportControllerTest < ActionController::TestCase
  test "should get google_sheet" do
    get :google_sheet
    assert_response :success
  end

  test "should get json" do
    get :json
    assert_response :success
  end

  test "should get csv" do
    get :csv
    assert_response :success
  end

  test "should get xlsx" do
    get :xlsx
    assert_response :success
  end

end
