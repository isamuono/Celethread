json.array!(@events) do |event|
  json.extract! event, :title, :place
  json.community_id event.community_id
  json.start event.startdate
  json.end event.enddate
  json.dateRange event.daterange
  json.allDay event.allday
  json.color event.channel.color
  #json.url event_url(event, format: :json)
end