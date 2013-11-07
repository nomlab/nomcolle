class BowlingTeam < ActiveRecord::Base
  belongs_to :bowling_match
  has_many :bowling_scores
  has_many :bowling_team_memberships
  has_many :users, :through => :bowling_team_memberships
  belongs_to :room
end
