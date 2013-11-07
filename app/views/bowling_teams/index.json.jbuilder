json.array!(@bowling_teams) do |bowling_team|
  json.extract! bowling_team, :name, :bowling_match_id, :room_id
  json.url bowling_team_url(bowling_team, format: :json)
end
