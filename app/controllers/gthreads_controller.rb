class GthreadsController < ApplicationController
  before_action :login_check, :set_user_id_to_cookie
  #before_action :set_channel_id
  before_action :is_com_participant?, only: [:index, :show_additionally]
  before_action :is_gthread_author?, only: :destroy
  
  def set_channel_id
    @channel = Channel.find(params[:channel_id])
  end
  
  def index
    @user = current_user
    
    @gthread = Gthread.new
    
    @communities = current_user.communities
    #@communities = Community.all#.includes(:communitiy_participants)
    #@communitiy_participants.each do |com|
    #  Communities.name
    #  com.channels.each do |channel|
     # end
    #end
    
    #com_ary1 = Array.new("F.L.Tクラブ", Array.new("F.L.Tクラブ", "ミーティング"), Array.new("F.L.Tクラブ", "合宿") )
    #com_ary2 = Array.new("ミーティング", "合宿")
    #com_ary2 = Array.new("Tech Boost", Array.new("Tech Boost", "オンラインサポート") )
    #com_ary = [["F.L.Tクラブ", "ミーティング", ]]
    
    if params[:channel_id] && Channel.exists?(id: params[:channel_id])
      @channel = Channel.find(params[:channel_id])#_by(id: @communities.first)
    else
      redirect_to channels_gthreads_path(current_user.communities.order(:created_at).first.channels.first.id)
      @community_first = Community.find(current_user.communities.order(:created_at).first.id)
      @channel = Channel.find(@community_first.channels.first.id)
    end
    
    @gthreads = @channel.gthreads.includes(:user, :thread_reaction_users, :thread_reactions).order(:created_at).last(4)
    
    gon.channel_id = @channel.id
    
    @thread_reactions = ThreadReaction.all
    @comment = Comment.new
    
    gon.current_user_id = current_user.id
    
    #respond_to do |format| 
    #  format.html
    #  format.json { @new_thread = Gthread.includes(:user, :thread_reaction_users, :thread_reactions).where('id > ?', params[:thread][:id]) }
    #end
    
    @unchecked_notifications = current_user.passive_notifications.where(checked: false).where.not(visitor_id: current_user.id)
  end
  
  def create
    @gthread = Gthread.new(thread_params)
    @gthread.user_id = current_user.id
    @channel = Channel.find_by(id: thread_params[:channel_id])
    @gthread.save
    
    ActionCable.server.broadcast "gthread_channel_#{ @channel.id }", gthread: @gthread.template, gthread_id: @gthread['id'], channel_id: @gthread['channel_id'], current_user_id: current_user.id, user_id: @gthread.user_id, title: @gthread.title,
        gthread_user_name: @gthread.user.accountName, gthread_user_images: @gthread.user.images.url, gthread_user_self_introduction: @gthread.user.self_introduction,
        gthread_user_communities_count: @gthread.user.communities.count, gthread_user_created_at: @gthread.user.created_at.strftime("%-Y#{'年'}%-m#{'月'}"),
        channel_name: @gthread.channel.channelName, channel_color: @gthread.channel.color,
        community_participant_id: @gthread.channel.community.users.find(@gthread.user_id).id
    
    # 通知機能
    # 公開チャンネルのスレッドの場合、同じコミュニティー参加者全員に通知を知らせる
    if @gthread.channel.public == 2
      temp_ids = @gthread.channel.community.users.select(:id).where.not(id: current_user.id).distinct
    elsif @gthread.channel.public == 1
      temp_ids = @gthread.channel.community.users.select(:id).where(community_participants: { role: 1 }).where.not(id: current_user.id).distinct
    end
    
    temp_ids.each do |temp_id|
      notification = current_user.active_notifications.new(
        gthread_id: @gthread.id,
        visited_id: temp_id['id'],#@gthread.channel.community.users,#visited_id,
        action: 'gthread'
      )
      # 自分の投稿したスレッドの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def notification_index
    @notifications = current_user.passive_notifications.where(checked: false)
  end
  
  def reaction_image_index
    @thread_reaction_image = Gthread.find(params[:id])
    
    @reaction_images_custom = ReactionImage.where(emoji_id: '1')
    @reaction_images_smileys_and_emotion = ReactionImage.where(emoji_id: '2')
    @reaction_images_body_and_gesture_and_person = ReactionImage.where(emoji_id: '3')
    @reaction_images_nature_and_place = ReactionImage.where(emoji_id: '4')
    @reaction_images_activity_and_tradition_and_features = ReactionImage.where(emoji_id: '5')
    @reaction_images_objects_and_others = ReactionImage.where(emoji_id: '6')
    @reaction_images_symbols = ReactionImage.where(emoji_id: '7')
    
  end
  
  def comment_index
    @thread_comment = Gthread.find(params[:id])
    @comments = @thread_comment.comments.includes(:user)
    @channel = @thread_comment.channel
    @comment = Comment.new
  end
  
  def show_additionally
    @channel = Channel.find(params[:channel_id])
    last_id = params[:oldest_gthread_id].to_i - 1
    @gthreads = @channel.gthreads.includes(:user, :thread_reaction_users, :thread_reactions).order(:created_at).where(id: 1..last_id).last(5)
  end
  
  #def new
  #  @gthread = Gthread.new
  #  @gthread.channel_id = params[:channel_id]
  #end
  
  def destroy
    @gthread = Gthread.find_by(user_id: current_user.id, id: params[:id])
    
    if @gthread.destroy
      ActionCable.server.broadcast 'gthread_delete_channel', gthread_id: @gthread['id']
    end
  end
  
  private
    def thread_params
      params.require(:gthread).permit(:user_id, :community_id, :channel_id, :title, :description, { images: [] })#merge(:channel_id)
    end
    
    def is_gthread_author?
      if current_user.id == Gthread.find_by(id: params[:id]).user_id
        true
      else
        redirect_to request.referer, danger: 'あなたにはこのスレッドを削除出来る権限がありません'
      end
    end
end
