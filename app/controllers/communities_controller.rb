class CommunitiesController < ApplicationController
  before_action :login_check
  before_action :has_admin_right?, only: [:community_edit, :destroy]
  before_action :has_admin_right_at_community?, only: :update
  
  def new
    session[:previous_url] = request.referer
    
    @community = Community.new
    
    @subcategories1 = Subcategory.where(category_id: 1)
    @sub1 = '"---"'
    @sub1_id = '""'
    @subcategories1.each do |sub|
      item = ',"' + sub.name + '"'
      @sub1 = @sub1 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub1_id = @sub1_id + item_id
    end
      
    @subcategories2 = Subcategory.where(category_id: 2)
    @sub2 = '"---"'
    @sub2_id = '""'
    @subcategories2.each do |sub|
      item = ',"' + sub.name + '"'
      @sub2 = @sub2 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub2_id = @sub2_id + item_id
    end
    
    @subcategories3 = Subcategory.where(category_id: 3)
    @sub3 = '"---"'
    @sub3_id = '""'
    @subcategories3.each do |sub|
      item = ',"' + sub.name + '"'
      @sub3 = @sub3 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub3_id = @sub3_id + item_id
    end
    
    @subcategories4 = Subcategory.where(category_id: 4)
    @sub4 = '"---"'
    @sub4_id = '""'
    @subcategories4.each do |sub|
      item = ',"' + sub.name + '"'
      @sub4 = @sub4 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub4_id = @sub4_id + item_id
    end
  end
  
  def create
    @community = Community.new(community_params)
    @community.user_id = current_user.id
    if @community.category_id == 5
      @community.subcategory_id = 43
    end
    @community.public = 2 # 基本的に全て公開にする
    
    if @community.save
      @community_participate = CommunityParticipant.new
      @community_participate.user_id = current_user.id
      @community_participate.community_id = @community.id
      @community_participate.role = 1 # コミュニティー開設者はそのコミュニティーの管理者になる
      @community_participate.save
      
      redirect_to session[:previous_url], success: 'コミュニティーを開設しました'
    else
      flash.now[:danger] = "コミュニティー作成に失敗しました"
      
      @subcategories1 = Subcategory.where(category_id: 1)
      @sub1 = '"---"'
      @sub1_id = '""'
      @subcategories1.each do |sub|
        item = ',"' + sub.name + '"'
        @sub1 = @sub1 + item
        item_id = ',"' + sub.id.to_s + '"'
        @sub1_id = @sub1_id + item_id
      end
        
      @subcategories2 = Subcategory.where(category_id: 2)
      @sub2 = '"---"'
      @sub2_id = '""'
      @subcategories2.each do |sub|
        item = ',"' + sub.name + '"'
        @sub2 = @sub2 + item
        item_id = ',"' + sub.id.to_s + '"'
        @sub2_id = @sub2_id + item_id
      end
      
      @subcategories3 = Subcategory.where(category_id: 3)
      @sub3 = '"---"'
      @sub3_id = '""'
      @subcategories3.each do |sub|
        item = ',"' + sub.name + '"'
        @sub3 = @sub3 + item
        item_id = ',"' + sub.id.to_s + '"'
        @sub3_id = @sub3_id + item_id
      end
      
      @subcategories4 = Subcategory.where(category_id: 4)
      @sub4 = '"---"'
      @sub4_id = '""'
      @subcategories4.each do |sub|
        item = ',"' + sub.name + '"'
        @sub4 = @sub4 + item
        item_id = ',"' + sub.id.to_s + '"'
        @sub4_id = @sub4_id + item_id
      end
      
      render :new
    end
  end
  
  #def index
  #  @communities = Community.all
  #end
  
  def community_show
    @community_show_modal = Community.find(params[:id])
    @cp_current_user = @community_show_modal.community_participants.find_by(user_id: current_user.id)
  end
  
  def community_edit
    @community_edit_modal = Community.find(params[:community_id])
    @cp_current_user = @community_edit_modal.community_participants.find_by(user_id: current_user.id)
    
    @subcategories1 = Subcategory.where(category_id: 1)
    @sub1 = '"---"'
    @sub1_id = '""'
    @subcategories1.each do |sub|
      item = ',"' + sub.name + '"'
      @sub1 = @sub1 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub1_id = @sub1_id + item_id
    end
      
    @subcategories2 = Subcategory.where(category_id: 2)
    @sub2 = '"---"'
    @sub2_id = '""'
    @subcategories2.each do |sub|
      item = ',"' + sub.name + '"'
      @sub2 = @sub2 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub2_id = @sub2_id + item_id
    end
    
    @subcategories3 = Subcategory.where(category_id: 3)
    @sub3 = '"---"'
    @sub3_id = '""'
    @subcategories3.each do |sub|
      item = ',"' + sub.name + '"'
      @sub3 = @sub3 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub3_id = @sub3_id + item_id
    end
    
    @subcategories4 = Subcategory.where(category_id: 4)
    @sub4 = '"---"'
    @sub4_id = '""'
    @subcategories4.each do |sub|
      item = ',"' + sub.name + '"'
      @sub4 = @sub4 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub4_id = @sub4_id + item_id
    end
  end
  
  def update
    @community_edit_modal = Community.find(community_params[:id])
    if @community_edit_modal.category_id == 5 # [その他]
      @community_edit_modal.subcategory_id = 43 # [その他]
    end
    
    if @community_edit_modal.update(community_params)
      redirect_to request.referer, success: @community_edit_modal.communityName + 'を変更しました'
    else
      redirect_to request.referer, danger: "コミュニティー情報の変更に失敗しました"
    end
  end
  
  def destroy
    @community_edit_modal = Community.find_by(user_id: current_user.id, id: params[:id]) #role値
    
    if @community_edit_modal.destroy
      redirect_to request.referer, success: 'コミュニティーを削除しました'
    else
      redirect_to request.referer, danger: "コミュニティーの削除に失敗しました"
    end
  end
  
  private
    def community_params
      params.require(:community).permit(:id, :communityName, :category_id, :subcategory_id, :prefecture_id, :sex, :scale, :images, :description)
    end
    
    def has_admin_right_at_community?
      if cp_current_user = current_user.community_participants.find_by(community_id: community_params[:id])
        if cp_current_user.role == 1
          true
        elsif cp_current_user.role == 2
          redirect_to request.referer, danger: 'あなたには権限がありません'
        end
      else
        redirect_to request.referer, danger: 'あなたはこのコミュニティーに参加していません'
      end
    end
end