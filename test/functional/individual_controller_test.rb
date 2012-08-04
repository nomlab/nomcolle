require 'test_helper'

class IndividualControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
