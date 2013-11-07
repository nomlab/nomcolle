class CreateBowlingMatches < ActiveRecord::Migration
  def change
    create_table :bowling_matches do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.string :filename
      t.string :steward

      t.timestamps
    end
  end
end
