class BowlingTeamsController < ApplicationController
  before_action :set_bowling_team, only: [:show, :edit, :update, :destroy]

  # GET /bowling_teams
  # GET /bowling_teams.json
  def index
    @bowling_teams = BowlingTeam.all
  end

  # GET /bowling_teams/1
  # GET /bowling_teams/1.json
  def show
  end

  # GET /bowling_teams/new
  def new
    @bowling_team = BowlingTeam.new
  end

  # GET /bowling_teams/1/edit
  def edit
  end

  # POST /bowling_teams
  # POST /bowling_teams.json
  def create
    @bowling_team = BowlingTeam.new(bowling_team_params)

    respond_to do |format|
      if @bowling_team.save
        format.html { redirect_to @bowling_team, notice: 'Bowling team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bowling_team }
      else
        format.html { render action: 'new' }
        format.json { render json: @bowling_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bowling_teams/1
  # PATCH/PUT /bowling_teams/1.json
  def update
    respond_to do |format|
      if @bowling_team.update(bowling_team_params)
        format.html { redirect_to @bowling_team, notice: 'Bowling team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bowling_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bowling_teams/1
  # DELETE /bowling_teams/1.json
  def destroy
    @bowling_team.destroy
    respond_to do |format|
      format.html { redirect_to bowling_teams_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bowling_team
      @bowling_team = BowlingTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bowling_team_params
      params.require(:bowling_team).permit(:name, :bowling_match_id, :room_id)
    end
end
