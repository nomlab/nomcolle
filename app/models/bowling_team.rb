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

  def self.top_n_of_bowling_match_id(n, bowling_match_id)
    self.where("bowling_match_id IS ?", bowling_match_id).order("average_score desc").take(n)
  end

  def calculate_total_score
    scores = self.bowling_scores.map {|bowling_score| bowling_score.score }
    self.total_score = (scores.compact.empty? ? nil : scores.sum)
    self.save
  end

  def calculate_average_score
    users_number = self.users.size
    self.average_score = (users_number == 0 || total_score == nil ? nil : total_score / users_number)
    self.save
  end

end
