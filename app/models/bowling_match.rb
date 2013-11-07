class BowlingMatch < ActiveRecord::Base
  has_many :bowling_teams
  has_many :bowling_scores
end
