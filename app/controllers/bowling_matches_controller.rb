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
    @bowling_teams = @bowling_match.bowling_teams
    #@members = @bowling_teams.users
    @scores = @bowling_match.bowling_scores
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bowling_match
      @bowling_match = BowlingMatch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bowling_match_params
      params.require(:bowling_match).permit(:name, :start_time, :end_time, :filename, :steward)
    end
end
