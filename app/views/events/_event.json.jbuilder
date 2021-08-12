json.extract! event, :title, :startdate, :enddate, :daterange, :allday, :description, :place, :color
json.url event_url(event, format: :json)
