class CommunityParticipantsController < ApplicationController
  before_action :login_check
  
  def index
    @communities = Community.all
  end
  
  def create
    @participate = CommunityParticipant.new
    @participate.role = 2
    @participate.user_id = current_user.id
    @participate.community_id = params[:community_id]
    
    if @participate.save
      #flash.now[:success] = '参加しました'
      redirect_to community_participants_path, success: '参加しました'
    else
      #binding.pry
      redirect_to community_participants_path, danger: '参加申請に失敗しました'
    end
  end
  
  def update
    @participant = CommunityParticipant.find(params[:id])
    
    if @participant.role == 2
      @participant.update(role: 1)
    else
      @participant.update(role: 2)
    end
  end
  
  private
    def participant_params
      params.require(:communitiy_participant).permit(:role)
    end
end
