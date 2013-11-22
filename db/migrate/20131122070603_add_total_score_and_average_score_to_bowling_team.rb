class AddTotalScoreAndAverageScoreToBowlingTeam < ActiveRecord::Migration
  def change
    add_column :bowling_teams, :total_score, :integer
    add_column :bowling_teams, :average_score, :integer
  end
end
