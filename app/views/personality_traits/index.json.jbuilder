json.array!(@personality_traits) do |personality_trait|
  json.extract! personality_trait, :id
  json.url personality_trait_url(personality_trait, format: :json)
end
