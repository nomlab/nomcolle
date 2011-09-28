require 'test_helper'

class SubscriptionRequestsControllerTest < ActionController::TestCase
  setup do
    @subscription_request = subscription_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscription_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subscription_request" do
    assert_difference('SubscriptionRequest.count') do
      post :create, subscription_request: @subscription_request.attributes
    end

    assert_redirected_to subscription_request_path(assigns(:subscription_request))
  end

  test "should show subscription_request" do
    get :show, id: @subscription_request.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscription_request.to_param
    assert_response :success
  end

  test "should update subscription_request" do
    put :update, id: @subscription_request.to_param, subscription_request: @subscription_request.attributes
    assert_redirected_to subscription_request_path(assigns(:subscription_request))
  end

  test "should destroy subscription_request" do
    assert_difference('SubscriptionRequest.count', -1) do
      delete :destroy, id: @subscription_request.to_param
    end

    assert_redirected_to subscription_requests_path
  end
end
