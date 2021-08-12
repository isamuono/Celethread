if @new_thread.present?
  json.array! @new_thread do |thread|
    json.id thread.id
    json.user_id thread.user_id
    json.community_id thread.community_id
    json.channel_id thread.channel_id
    json.event_id thread.event_id
    json.title thread.title
    json.images thread.images
    json.description thread.description
    json.created_at thread.created_at.strftime("%-m.%-d(#{%w(日 月 火 水 木 金 土)[thread.created_at.wday]}) %-H:%M")
    json.reactions_count thread.thread_reactions.count
    json.comments_count thread.comments.count
    json.user_id thread.user.id
    json.user_accountName thread.user.accountName
    json.user_image thread.user.images.url
  end
end