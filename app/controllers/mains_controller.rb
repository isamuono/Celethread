class MainsController < ApplicationController
  before_action :login_check
  #before_action :set_channel_id
  
  def set_channel_id
    @channel = Channel.find(params[:id])
  end
  
  def index
    @user = current_user
    
    @thread = Gthread.new
    #@thread.channel_id = params[:channel_id]
    
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
    
    ch = current_user.channels.first
    @channel = Channel.all.first
    #@threads = Gthread.includes(:user, :thread_reaction_users, :thread_reactions).order(:id).last(5)
    @threads = @channel.gthreads.includes(:user, :thread_reaction_users, :thread_reactions).order(:id).last(9)
    #@threads = Gthread.page(params[:threads_page]).reverse_order.per(10) #reverse_order
    #@treactions_count = @thread_reactions.reaction_images.count
    
    @thread_reactions = ThreadReaction.all
    @comment = Comment.new
    
    # 10月追記
    #block = ThreadReaction.pluck(:gthread_id, :entity_name)
    #hash_count = block.group_by(&:itself).transform_values(&:size)
    #ary_count = hash_count.to_a
    #@treaction_list = ary_count.sort_by {|k,v| v}.reverse
    
    #threaction_results = ThreadReaction.all
    #@treaction_list = threaction_results.group(:gthread_id, :entity_name)
    #
    
    
    @reaction_images_custom = ReactionImage.where(emoji_id: '1')
    @reaction_images_smileys_and_emotion = ReactionImage.where(emoji_id: '2')
    @reaction_images_body = ReactionImage.where(emoji_id: '3')
    @reaction_images_person_and_gesture = ReactionImage.where(emoji_id: '4')
    @reaction_images_symbols = ReactionImage.where(emoji_id: '5')
    
    @reaction_emojis = ReactionEmoji.all
  end
  
  def show
    @user = current_user
    @communities = current_user.communities
    
    @thread = Gthread.new
    
    @channel = Channel.find(params[:id])
    #@threads = Gthread.where(channel_id: params[:id]).order(:id).last(4)
    @threads = @channel.gthreads.includes(:user, :thread_reaction_users, :thread_reactions).order(:id).last(4)
    
    @thread_reactions = ThreadReaction.all
    @comment = Comment.new
    
    @reaction_images_custom = ReactionImage.where(emoji_id: '1')
    @reaction_images_smileys_and_emotion = ReactionImage.where(emoji_id: '2')
    @reaction_images_body = ReactionImage.where(emoji_id: '3')
    @reaction_images_person_and_gesture = ReactionImage.where(emoji_id: '4')
    @reaction_images_symbols = ReactionImage.where(emoji_id: '5')
    #@reaction_emojis = ReactionEmoji.all
    
    #@thread_reaction = ThreadReaction.find(params[:id])
  end
  
  def show_additionally
    last_id = params[:oldest_gthread_id].to_i - 1
    @threads = Gthread.includes(:user, :thread_reaction_users, :thread_reactions).order(:id).where(id: 1..last_id).last(2)
    
    @thread_reactions = ThreadReaction.all
    @comment = Comment.new
    
    @reaction_images_custom = ReactionImage.where(emoji_id: '1')
    @reaction_images_smileys_and_emotion = ReactionImage.where(emoji_id: '2')
    @reaction_images_body = ReactionImage.where(emoji_id: '3')
    @reaction_images_person_and_gesture = ReactionImage.where(emoji_id: '4')
    @reaction_images_symbols = ReactionImage.where(emoji_id: '5')
  end
  
  def create
    @thread_reactions = ThreadReaction.new
    @thread_reactions.user_id = current_user.id
    @thread_reactions.gthread_id = params[:gthread_id]
    @thread_reactions.entity_name = params[:entity_name]
    @thread_reactions.images = params[:images]
    
    if @thread_reactions.save
      redirect_to gthreads_path, success: 'リアクションしました'
    else
      redirect_to gthreads_path, danger: "リアクションに失敗しました"
    end
  end
end