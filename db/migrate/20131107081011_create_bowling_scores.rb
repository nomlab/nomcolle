class CreateBowlingScores < ActiveRecord::Migration
  def change
    create_table :bowling_scores do |t|
      t.integer :score
      t.integer :member_id
      t.integer :bowling_match_id
      t.integer :bowling_team_id
      t.integer :game_number

      t.timestamps
    end
  end
end
