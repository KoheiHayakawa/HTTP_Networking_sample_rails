json.array!(@entries) do |entry|
  json.extract! entry, :id, :title, :body
  json.url entry_url(entry, format: :json)
end
