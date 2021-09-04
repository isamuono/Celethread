module GthreadsHelper
  #def channel_public_check
    #if channel = Channel.find(params[:channel_id])
    #  cp_current_user = current_user.community_participants.find_by(community_id: channel.community_id)
    
    #  unless channel.public == 2 || cp_current_user.role == 1
    #    redirect_to channels_gthreads_path(current_user.communities.order(:created_at).first.channels.first.id), danger: 'あなたにはこのチャンネルを閲覧する権限がありません'
    #  end
    #else
    #  redirect_to channels_gthreads_path(current_user.communities.order(:created_at).first.channels.first.id), danger: 'このチャンネルは存在しません'
    #end
  #end
end
