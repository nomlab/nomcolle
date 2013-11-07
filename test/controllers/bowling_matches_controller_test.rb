require 'test_helper'

class BowlingMatchesControllerTest < ActionController::TestCase
  setup do
    @bowling_match = bowling_matches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bowling_matches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bowling_match" do
    assert_difference('BowlingMatch.count') do
      post :create, bowling_match: { end_time: @bowling_match.end_time, filename: @bowling_match.filename, name: @bowling_match.name, start_time: @bowling_match.start_time, steward: @bowling_match.steward }
    end

    assert_redirected_to bowling_match_path(assigns(:bowling_match))
  end

  test "should show bowling_match" do
    get :show, id: @bowling_match
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bowling_match
    assert_response :success
  end

  test "should update bowling_match" do
    patch :update, id: @bowling_match, bowling_match: { end_time: @bowling_match.end_time, filename: @bowling_match.filename, name: @bowling_match.name, start_time: @bowling_match.start_time, steward: @bowling_match.steward }
    assert_redirected_to bowling_match_path(assigns(:bowling_match))
  end

  test "should destroy bowling_match" do
    assert_difference('BowlingMatch.count', -1) do
      delete :destroy, id: @bowling_match
    end

    assert_redirected_to bowling_matches_path
  end
end
