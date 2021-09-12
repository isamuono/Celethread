class CommentsController < ApplicationController
  before_action :login_check
  before_action :is_the_person_who_comment?, only: :destroy
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.community_participant_role = current_user.community_participants.find_by(community_id: @comment.gthread.channel.community_id).role
    @comment.save
    
    ActionCable.server.broadcast "comment_channel", my_comment: @comment.my_comment, others_comment: @comment.others_comment, tcomment_count: @comment.comment_count_template,
        comment_id: @comment['id'], gthread_id: @comment['gthread_id'], g_uid: @comment.gthread['g_uid'], user_id: @comment['user_id'],
        channel_id: @comment.gthread.channel.id
    
    # 通知機能
    # スレッド投稿者
    gthread_user = @comment.gthread.user
    # コミュニティー責任者（コメントした本人以外とスレッド投稿者以外）
    cps_role_1 = @comment.gthread.channel.community.users.select(:id).where(community_participants: { role: 1 })
                      .where.not(id: current_user.id).where.not(id: gthread_user.id).distinct
    
    # まず、スレッド投稿者に通知を知らせる
    notification_gthread_user = current_user.active_notifications.new(
      gthread_id: @comment['gthread_id'],
      comment_id: @comment['id'],
      visited_id: gthread_user.id,
      action: 'comment'
    )
    
    # 自分の投稿したスレッドに対する自身のコメントは通知しない。
    unless notification_gthread_user.visitor_id == notification_gthread_user.visited_id
      notification_gthread_user.save if notification_gthread_user.valid?
    end
    
    # 公開チャンネルのスレッドの場合
    if @comment.gthread.channel.public == 2
      # スレッド投稿者が参加メンバーの場合
      if gthread_user.community_participants.find_by(community_id: @comment.gthread.channel.community.id).role == 2
        # コメント済みのユーザー全員に通知を知らせる。ただし自分自身、スレッド投稿者には通知はしない。
        temp_ids = @comment.gthread.comment_users.select(:id).where(comments: { gthread_id: @comment.gthread_id })
                      .where.not(id: current_user.id).where.not(id: gthread_user.id).distinct
      # スレッド投稿者が責任者の場合
      elsif gthread_user.community_participants.find_by(community_id: @comment.gthread.channel.community.id).role == 1
        # コメント済みのユーザー全員に通知を知らせる。ただし自分自身、スレッド投稿者、コミュニティー責任者には通知はしない。
        temp_ids = @comment.gthread.comment_users.select(:id).where(comments: { gthread_id: @comment.gthread_id })
                      .where.not(id: current_user.id).where.not(id: gthread_user.id).where.not(comments: { community_participant_role: 1 }).distinct
        
        # 責任者全員に通知を知らせる。ただし、コメントした本人とスレッド投稿者には通知しない。
        cps_role_1.each do |cp_role_1|
          notification_cp_role_1 = current_user.active_notifications.new(
            gthread_id: @comment['gthread_id'],
            comment_id: @comment['id'],
            visited_id: cp_role_1.id,
            action: 'comment'
          )
          
          notification_cp_role_1.save if notification_cp_role_1.valid?
        end
      end
    # 非公開チャンネルのスレッドの場合
    elsif @comment.gthread.channel.public == 1
      # 責任者全員に通知を知らせる。ただし、コメントした本人とスレッド投稿者には通知しない。
      temp_ids = cps_role_1
    end
    
    temp_ids.each do |temp_id|
      notification = current_user.active_notifications.new(
        gthread_id: @comment['gthread_id'],
        comment_id: @comment['id'],
        visited_id: temp_id['id'],
        action: 'comment'
      )
      
      unless notification.visitor_id == notification.visited_id
        notification.save if notification.valid?
      end
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    
    if @comment.destroy
      ActionCable.server.broadcast 'comment_delete_channel', tcomment_count: @comment.comment_count_template,
          comment_id: @comment['id'], gthread_id: @comment['gthread_id']
    end
  end
  
  private
    def comment_params
      params.require(:comment).permit(:gthread_id, :text)
    end
    
    def is_the_person_who_comment?
      if current_user.id == Comment.find_by(id: params[:id]).user_id
        true
      else
        redirect_to request.referer, danger: 'あなたはこのコメントを削除出来ません'
      end
    end
end