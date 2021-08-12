class GthreadBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment, params)
    # スライドIDごとのチャンネルに対してメッセージ送信
    ActionCable.server.broadcast "gthread_channel_#{params[:channel_id]}", comment: comment
  end
end