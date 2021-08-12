class ChannelsController < ApplicationController
  before_action :login_check, :set_user_id_to_cookie
  before_action :previous_channel_id, only: :channel_change
  
  def new
    @channel = Channel.new
    @channel.community_id = params[:community_id]
  end
  
  def create
    @channel = Channel.new(channel_params)
    @channel.user_id = current_user.id #コミュニティ管理者のid
    if @channel.save
      redirect_to channels_gthreads_path(@channel.id), success: 'チャンネルを作成しました'
    else
      flash.now[:danger] = "チャンネル作成に失敗しました"
      render :new
    end
  end
  
  def previous_channel_id
    session[:previous_channel_id] = params[:channel_id]
  end
  
  def channel_change
    #session[:previous_url] = request.referer
    @previous_channel_id = session[:previous_channel_id]
    
    @channel = Channel.find(params[:channel_id])
    @gthread = Gthread.new
    @gthreads = @channel.gthreads.includes(:user, :thread_reaction_users, :thread_reactions).order(:id).last(4)
  end
  
  def channel_show
    @channel_show_modal = Channel.find(params[:id])
    @cp_current_user = @channel_show_modal.community.community_participants.find_by(user_id: current_user.id)
  end
  
  def channel_edit
    @channel_edit_modal = Channel.find(params[:id])
  end
  
  def update
    @channel_edit_modal = Channel.find(params[:channel][:id])
    
    if @channel_edit_modal.update(channel_params)
      redirect_to request.referer, success: @channel_edit_modal.channelName + 'チャンネルを変更しました'
    else
      redirect_to request.referer, danger: "チャンネル情報の変更に失敗しました"
    end
  end
  
  def destroy
    @channel_edit_modal = Channel.find(params[:id]) #public値
    
    if @channel_edit_modal.destroy
      redirect_to request.referer, success: "チャンネルを削除しました"
    else
      redirect_to request.referer, danger: "チャンネルの削除に失敗しました"
    end
  end
  
  private
    def channel_params
      params.require(:channel).permit(:community_id, :channelName, :description, :color, :public)
    end
end
