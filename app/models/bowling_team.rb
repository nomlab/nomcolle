class BowlingTeam < ActiveRecord::Base
  belongs_to :bowling_match
  has_many :bowling_scores
  has_many :bowling_team_memberships
  has_many :users, :through => :bowling_team_memberships
  belongs_to :room

  def self.new_team_by_team_number(bowling_match_id,team_number = 1)
    teams = Array.new
    (1..team_number).each do |num|
      teams << self.new(:name => "Team#{num}", :bowling_match_id => bowling_match_id)
    end
    return teams
  end

  def total_score
    scores = self.bowling_scores.map {|bowling_score| bowling_score.score }
    scores.compact.empty? ? nil : scores.sum
  end

  def average_score
    users_number = self.users.size
    users_number == 0 || total_score == nil ? nil : total_score / users_number
  end

end
