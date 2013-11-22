class BowlingScore < ActiveRecord::Base
  belongs_to :bowling_match
  belongs_to :user
  belongs_to :bowling_team

  validates :score, :numericality => {:only_integer => true, :less_than_or_equal_to => 300, :greater_than_or_equal_to => 0}

  def self.create_by_game_number(user_id, bowling_match_id, game_number = 1)
    (1..game_number).each do |num|
      if self.find_by_user_id_and_bowling_match_id_and_game_number(user_id, bowling_match_id, num) == nil
        self.create(:user_id => user_id, :bowling_match_id => bowling_match_id, :game_number => num)
      end
    end
  end
end
