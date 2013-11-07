require 'test_helper'

class BowlingTeamsControllerTest < ActionController::TestCase
  setup do
    @bowling_team = bowling_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bowling_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bowling_team" do
    assert_difference('BowlingTeam.count') do
      post :create, bowling_team: { bowling_match_id: @bowling_team.bowling_match_id, name: @bowling_team.name, room_id: @bowling_team.room_id }
    end

    assert_redirected_to bowling_team_path(assigns(:bowling_team))
  end

  test "should show bowling_team" do
    get :show, id: @bowling_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bowling_team
    assert_response :success
  end

  test "should update bowling_team" do
    patch :update, id: @bowling_team, bowling_team: { bowling_match_id: @bowling_team.bowling_match_id, name: @bowling_team.name, room_id: @bowling_team.room_id }
    assert_redirected_to bowling_team_path(assigns(:bowling_team))
  end

  test "should destroy bowling_team" do
    assert_difference('BowlingTeam.count', -1) do
      delete :destroy, id: @bowling_team
    end

    assert_redirected_to bowling_teams_path
  end
end
