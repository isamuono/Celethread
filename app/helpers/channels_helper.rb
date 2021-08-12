module ChannelsHelper
  def channel_public_check(public)
    cu = current_user.communitiy_participants.find_by()
    @channel.public = Channel.find_by(cu)
  end
end
