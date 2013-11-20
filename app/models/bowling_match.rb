class BowlingMatch < ActiveRecord::Base
  has_many :bowling_teams, :order => 'average_score DESC'
  has_many :bowling_scores
  has_many :users, :through => :bowling_scores
end
