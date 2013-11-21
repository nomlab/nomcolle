class BowlingMatch < ActiveRecord::Base
  has_many :bowling_teams
  has_many :bowling_scores
  has_many :users, :through => :bowling_scores
end
