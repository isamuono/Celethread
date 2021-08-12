class GthreadDeleteChannel < ApplicationCable::Channel
  def subscribed
    stream_from "gthread_delete_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
