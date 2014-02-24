class User < ActiveRecord::Base
  has_many :histories
  has_many :reviews
  has_many :subscription_requests
  has_many :bowling_scores, :dependent => :delete_all
  has_many :bowling_team_memberships, :dependent => :delete_all
  has_many :bowling_teams, :through => :bowling_team_memberships
  belongs_to :room

  validates_uniqueness_of :login_name
  validates_presence_of :login_name, :password, :name



  def self.authenticate(login_name, password)
    if password.blank?
      return where(["login_name=? AND (password=? OR password IS NULL)",
                    login_name, password]).first
    else
      return where(["login_name=? AND password=?",
                    login_name, password]).first
    end
  end

  def self.current=(user)
    @current_user = user
  end

  def self.current
    @current_user
  end

  def self.top_n_of_bowling_match_id(n, bowling_match_id)
    players = BowlingMatch.find(bowling_match_id).users.uniq {|user| user.id}
    scores = Hash.new(Array.new)
    players.each do |player|
      player_total_score = 0
      player.bowling_scores_of_bowling_match(bowling_match_id).each do |bowling_score|
        player_total_score += bowling_score.score
      end
      scores[player.id.to_s] = player_total_score
    end
    sorted_scores = scores.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
    top_n_players_ids = Array.new
    sorted_scores.take(n).each do |id_and_score|
      top_n_players_ids << id_and_score.first
    end
    users = []
    top_n_players_ids.each do |id|
      users << self.find(id.to_i)
    end
    return users
  end

  def bowling_scores_of_bowling_match(bowling_match_id)
    BowlingScore.where("user_id is ? AND bowling_match_id is ? ", self.id, bowling_match_id)
  end
end
