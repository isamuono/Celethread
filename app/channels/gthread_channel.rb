class GthreadChannel < ApplicationCable::Channel
  def subscribed
    channel = Channel.find(params[:channel_id])
    stream_for channel.id
    
    # 参加していないコミュニティーのチャンネルのサブスクリプションは購読不可
    if current_user.is_com_participants?(channel)
      stream_from "gthread_channel_#{ params[:channel_id] }"
    else
      reject
    end
  end
  
  def unsubscribed
    #stop_stream_from "gthread_channel_#{params[:channel_id]}"
  end
  
  #def speak(data)
    #ActionCable.server.broadcast 'gthread_channel_#{ params[:channel_id] }', gthread: data['gthread']
  #  Gthread.create! description: data['direct_message'], user_id: current_user.id
  #end
  
  #private
    #def render_thread(gthread)
     # ActionController.render(
      #  partial: 'gthreads/gthread', locals: { gthread: gthread }
      #)
    #end
end
