json.array!(@pledges) do |pledge|
  json.extract! pledge, :id, :guest_id, :mansion_id, :start_date, :end_date, :total_price, :guest_id, :mansion_id
  json.url pledge_url(pledge, format: :json)
end
