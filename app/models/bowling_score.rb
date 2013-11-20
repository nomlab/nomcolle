class BowlingScore < ActiveRecord::Base
  belongs_to :bowling_match
  belongs_to :user
  belongs_to :bowling_team

  def self.create_by_game_number(user_id, bowling_match_id, game_number = 1)
    (1..game_number).each do |num|
      BowlingScore.create(:user_id => user_id, :bowling_match_id => bowling_match_id, :game_number => num)
    end
  end
end
