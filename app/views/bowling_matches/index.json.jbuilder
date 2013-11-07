json.array!(@bowling_matches) do |bowling_match|
  json.extract! bowling_match, :name, :start_time, :end_time, :filename, :steward
  json.url bowling_match_url(bowling_match, format: :json)
end
