class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comment_channel"
    #@thread = Gthread.find(params[:id])
    #stream_for(@thread)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
