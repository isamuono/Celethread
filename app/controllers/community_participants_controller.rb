class CommunityParticipantsController < ApplicationController
  before_action :login_check
  before_action :has_admin_right?, only: :update
  
  # コミュニティー検索ページ実装後使用する予定
  #def create
  #  @participate = CommunityParticipant.new
  #  @participate.role = 2
  #  @participate.user_id = current_user.id
  #  @participate.community_id = params[:community_id]
    
  #  if @participate.save
  #    redirect_to community_participants_path, success: '参加しました'
  #  else
  #    redirect_to community_participants_path, danger: '参加申請に失敗しました'
  #  end
  #end
  
  def update
    @participant = CommunityParticipant.find(params[:id])
    
    if @participant.role == 2
      @participant.update(role: 1)
      redirect_to request.referer, success: @participant.user.accountName + 'コミュニティー管理者に変更しました'
    else
      @participant.update(role: 2)
      redirect_to request.referer, success: @participant.user.accountName + '通常メンバーに変更しました'
    end
  end
  
  
    
end
