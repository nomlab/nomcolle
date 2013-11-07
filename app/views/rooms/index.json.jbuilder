json.array!(@rooms) do |room|
  json.extract! room, :name
  json.url room_url(room, format: :json)
end
