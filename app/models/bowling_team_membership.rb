class BowlingTeamMembership < ActiveRecord::Base
  belongs_to :bowling_team
  belongs_to :user
end
