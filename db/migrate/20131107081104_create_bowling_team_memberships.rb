class CreateBowlingTeamMemberships < ActiveRecord::Migration
  def change
    create_table :bowling_team_memberships do |t|
      t.integer :user_id
      t.integer :bowling_team_id

      t.timestamps
    end
  end
end
