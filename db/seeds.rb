# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(name: 'guest', login_name:'guest', password: 'guest')
bowling_match = BowlingMatch.create(name: 'test match', start_time: Time.now, end_time: Time.now, filename: 'sample.xls', steward: '106')
room = Room.create(name: '106')
team = BowlingTeam.create(name: 'test team', bowling_match_id: bowling_match.id, room_id: room.id, total_score: 500, average_score: 250)
BowlingTeamMembership.create(user_id: user.id, bowling_team_id: team.id)
BowlingScore.create(score: 300, user_id: user.id, bowling_match_id: bowling_match.id, bowling_team_id: team.id, game_number: 1)
BowlingScore.create(score: 200, user_id: user.id, bowling_match_id: bowling_match.id, bowling_team_id: team.id, game_number: 2)
