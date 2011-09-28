require 'test_helper'

class HistoriesControllerTest < ActionController::TestCase
  setup do
    @history = histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create history" do
    assert_difference('History.count') do
      post :create, history: @history.attributes
    end

    assert_redirected_to history_path(assigns(:history))
  end

  test "should show history" do
    get :show, id: @history.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @history.to_param
    assert_response :success
  end

  test "should update history" do
    put :update, id: @history.to_param, history: @history.attributes
    assert_redirected_to history_path(assigns(:history))
  end

  test "should destroy history" do
    assert_difference('History.count', -1) do
      delete :destroy, id: @history.to_param
    end

    assert_redirected_to histories_path
  end
end
