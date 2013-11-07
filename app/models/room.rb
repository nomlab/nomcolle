class Room < ActiveRecord::Base
  has_many :bowling_teams
  has_many :users
end
