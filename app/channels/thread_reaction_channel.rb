class ThreadReactionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "thread_reaction_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
