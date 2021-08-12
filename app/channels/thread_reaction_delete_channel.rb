class ThreadReactionDeleteChannel < ApplicationCable::Channel
  def subscribed
    stream_from "thread_reaction_delete_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
