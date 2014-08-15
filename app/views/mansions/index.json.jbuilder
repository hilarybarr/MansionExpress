json.array!(@mansions) do |mansion|
  json.extract! mansion, :id, :name, :description, :address, :continent, :city, :bedrooms, :bathrooms, :square_feet, :available_date
  json.url mansion_url(mansion, format: :json)
end
