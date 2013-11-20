class AddGameNumberToBowlingMatch < ActiveRecord::Migration
  def change
    add_column :bowling_matches, :game_number, :integer, :default => 1
  end
end
