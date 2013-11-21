class AddTeamNumberToBowlingMatch < ActiveRecord::Migration
  def change
    add_column :bowling_matches, :team_number, :integer, :default => 0
  end
end
