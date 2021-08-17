class GthreadBroadcastJob < ApplicationJob
  queue_as :default

  def perform(gthread, params)
    ActionCable.server.broadcast "gthread_channel_#{params[:channel_id]}", comment: comment
  end
end