# -*- coding: utf-8 -*-
class BowlingMatchesController < ApplicationController
  before_action :set_bowling_match, only: [:show, :edit, :update, :destroy]

  # GET /bowling_matches
  # GET /bowling_matches.json
  def index
    @bowling_matches = BowlingMatch.all
  end

  # GET /bowling_matches/1
  # GET /bowling_matches/1.json
  def show
    @bowling_match = BowlingMatch.find(params[:id])
    @game_number = @bowling_match.game_number
    @bowling_teams = @bowling_match.bowling_teams
    @players_list = @bowling_match.users.uniq {|user| user.id}
  end

  # GET /bowling_matches/new
  def new
    @bowling_match = BowlingMatch.new
  end

  # GET /bowling_matches/1/edit
  def edit
  end

  # POST /bowling_matches
  # POST /bowling_matches.json
  def create
    @bowling_match = BowlingMatch.new(bowling_match_params)
    respond_to do |format|
      if @bowling_match.save
        teams = BowlingTeam.new_team_by_team_number(@bowling_match.id, @bowling_match.team_number)
        @bowling_match.bowling_teams = teams
        format.html { redirect_to @bowling_match, notice: 'Bowling match was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bowling_match }
      else
        format.html { render action: 'new' }
        format.json { render json: @bowling_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bowling_matches/1
  # PATCH/PUT /bowling_matches/1.json
  def update
    respond_to do |format|
      if @bowling_match.update(bowling_match_params)
        format.html { redirect_to @bowling_match, notice: 'Bowling match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bowling_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bowling_matches/1
  # DELETE /bowling_matches/1.json
  def destroy
    @bowling_match.destroy
    respond_to do |format|
      format.html { redirect_to bowling_matches_url }
      format.json { head :no_content }
    end
  end

  def manage_bowling_players
    @bowling_match = BowlingMatch.find(params[:id])
    @users = User.all
    @bowling_teams = @bowling_match.bowling_teams
  end

  def register_players
    @bowling_match = BowlingMatch.find(params[:id])
    if params[:player] != nil
      match_player_ids = params[:player].keys
      match_player_ids.each do |player_id|
        BowlingScore.create_by_game_number(player_id, @bowling_match.id, @bowling_match.game_number)
      end
    end
    if params[:team] != nil
      team_player_ids = params[:team].keys
      team_player_ids.each do |player_id|
        if BowlingTeamMembership.where("user_id IS ? AND bowling_team_id IS ?", player_id, params[:team]["#{player_id}"].to_i) == []
          BowlingTeamMembership.create(:user_id => player_id, :bowling_team_id => params[:team]["#{player_id}"].to_i)
        end
        scores = BowlingScore.where("user_id IS ? AND bowling_match_id IS ?", player_id, @bowling_match.id)
        BowlingTeam.find(params[:team]["#{player_id}"].to_i).bowling_scores += scores
      end
    end
    redirect_to @bowling_match
  end

  def record_bowling_match_scores
    @bowling_match = BowlingMatch.find(params[:id])
    @game_number = @bowling_match.game_number
    @bowling_teams = @bowling_match.bowling_teams
    @players_list = @bowling_match.users.uniq {|user| user.id}
  end

  def update_bowling_match_scores
    @bowling_match = BowlingMatch.find(params[:id])
    @game_number = @bowling_match.game_number
    ActiveRecord::Base.transaction do
      params[:scores].keys.each do |user_id|
        user = User.find(user_id)
        (1..@game_number).each do |num|
          user.bowling_scores[num-1].score = params[:scores][user_id][num-1]
          user.bowling_scores[num-1].save!
        end
      end
    end
    @bowling_match.bowling_teams.all.each do |team|
      team.calculate_total_score
      team.calculate_average_score
    end
    redirect_to @bowling_match, notice: 'Bowling match scores were successfully updated.'
    return
  rescue  => e
    redirect_to @bowling_match, :flash => {error: 'Score is wrong.'}
  end

  # DELETE /bowling_matches/1
  # DELETE /bowling_matches/1.json
  def destroy_bowling_scores
    @bowling_match = BowlingMatch.find(params[:id])
    @bowling_scores = BowlingScore.find(params[:score_ids])
    @bowling_scores.map{ |score| score.destroy }
    respond_to do |format|
      format.html { redirect_to @bowling_match }
      format.json { head :no_content }
    end
  end

  def import_from_excel

  end

  def update_from_excel
    @bowling_match = BowlingMatch.find(params[:id])
    @excel = params[:file]
    @bowling_match.import_from_excel(@excel)
    redirect_to @bowling_match, notice: 'Updated'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bowling_match
      @bowling_match = BowlingMatch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bowling_match_params
      params.require(:bowling_match).permit(:name, :start_time, :end_time, :filename, :steward, :game_number, :team_number)
    end
end
