json.array!(@lounges) do |lounge|
  json.extract! lounge, :id
  json.url lounge_url(lounge, format: :json)
end
