class User < ActiveRecord::Base
  has_many :histories
  has_many :reviews
  has_many :subscription_requests

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
end
