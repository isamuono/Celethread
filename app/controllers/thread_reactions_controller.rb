class ThreadReactionsController < ApplicationController
  before_action :login_check
  
  def create
    @thread_reaction = ThreadReaction.new(thread_reaction_params)
    @thread_reaction.user_id = current_user.id
    thread_reaction_present_check = @thread_reaction.gthread.thread_reactions.where(entity_name: @thread_reaction.entity_name).present?
    @thread_reaction.save
    
    ActionCable.server.broadcast "thread_reaction_channel", thread_reaction: @thread_reaction.template, treaction_count_all: @thread_reaction.reaction_count_all_template,
        thread_reaction_already_present_check: thread_reaction_present_check, current_user_id: current_user.id, 
        user_id: @thread_reaction['user_id'], gthread_id: @thread_reaction['gthread_id'], entity_name: @thread_reaction['entity_name'], images: @thread_reaction['images'],
        treaction_user_accountName: @thread_reaction.user.accountName, channel_id: @thread_reaction.gthread.channel.id
    
    # 通知機能 @thread_reaction.gthread.create_notification_react!(current_user)
    # スレッド投稿者に通知を知らせる
    gthread_user = @thread_reaction.gthread.user
    
    notification_gthread_user = current_user.active_notifications.new(
      gthread_id: @thread_reaction['gthread_id'],
      thread_reaction_id: @thread_reaction['id'],
      visited_id: gthread_user.id,
      action: 'thread_reaction'
    )
    
    # 自分の投稿したスレッドに対する自身のリアクションは通知しない。
    unless notification_gthread_user.visitor_id == notification_gthread_user.visited_id
      notification_gthread_user.save if notification_gthread_user.valid?
    end
    
    # スレッド投稿者が責任者の場合
    if gthread_user.community_participants.find_by(community_id: @thread_reaction.gthread.channel.community.id).role == 1
      cps_role_1 = @thread_reaction.gthread.channel.community.users.select(:id).where(community_participants: { role: 1 })
                        .where.not(id: current_user.id).where.not(id: gthread_user.id).distinct
      
      # 責任者全員に通知を知らせる。ただし、リアクションした本人とスレッド投稿者には通知しない。
      cps_role_1.each do |cp_role_1|
        notification_cp_role_1 = current_user.active_notifications.new(
          gthread_id: @thread_reaction['gthread_id'],
          thread_reaction_id: @thread_reaction['id'],
          visited_id: cp_role_1.id,
          action: 'thread_reaction'
        )
        
        unless notification_cp_role_1.visitor_id == notification_cp_role_1.visited_id
          notification_cp_role_1.save if notification_cp_role_1.valid?
        end
      end
    end
  end
  
  def destroy
    @thread_reaction = ThreadReaction.find_by(user_id: current_user.id, gthread_id: thread_reaction_params[:gthread_id], entity_name: thread_reaction_params[:entity_name])
    @treaction_count = ThreadReaction.where(gthread_id: thread_reaction_params[:gthread_id], entity_name: thread_reaction_params[:entity_name]).count
    
    if @thread_reaction.destroy
      ActionCable.server.broadcast "thread_reaction_delete_channel", thread_reaction: @thread_reaction.template, treaction_count_check: @treaction_count, treaction_count_all: @thread_reaction.reaction_count_all_template,
          gthread_id: @thread_reaction['gthread_id'], entity_name: @thread_reaction['entity_name'], current_user_id: current_user.id, user_id: @thread_reaction['user_id']
    end
  end
  
  private
    def thread_reaction_params
      params.permit(:gthread_id, :entity_name, :images)
    end
end
