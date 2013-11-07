class CreateBowlingTeams < ActiveRecord::Migration
  def change
    create_table :bowling_teams do |t|
      t.string :name
      t.integer :bowling_match_id
      t.integer :room_id

      t.timestamps
    end
  end
end
