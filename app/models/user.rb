class User < ActiveRecord::Base
  has_many :histories
  has_many :reviews
  has_many :subscription_requests
  has_many :bowling_scores
  has_many :bowling_team_memberships
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

  def bowling_scores_of_bowling_match(bowling_match_id)
    BowlingScore.where("user_id is ? AND bowling_match_id is ? ", self.id, bowling_match_id)
  end
end
