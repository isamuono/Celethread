class CommunitiesController < ApplicationController
  before_action :login_check
  
  def new
    session[:previous_url] = request.referer
    
    @community = Community.new
    
    @subcategories1 = Subcategory.where(category_id: 1)
    @sub1 = '"---"'
    @subcategories1.each do |sub|
      item = ',"' + sub.name + '"'
      @sub1 = @sub1 + item
    end
      
    @subcategories2 = Subcategory.where(category_id: 2)
    @sub2 = '"---"'
    @subcategories2.each do |sub|
      item = ',"' + sub.name + '"'
      @sub2 = @sub2 + item
    end
    
    @subcategories3 = Subcategory.where(category_id: 3)
    @sub3 = '"---"'
    @subcategories3.each do |sub|
      item = ',"' + sub.name + '"'
      @sub3 = @sub3 + item
    end
    
    @subcategories4 = Subcategory.where(category_id: 4)
    @sub4 = '"---"'
    @subcategories4.each do |sub|
      item = ',"' + sub.name + '"'
      @sub4 = @sub4 + item
    end
  end
  
  def create
    @community = Community.new(community_params)
    @community.user_id = current_user.id
    if @community.category == 5
      @community.subcategory = 43
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
      @subcategories1.each do |sub|
        item = ',"' + sub.name + '"'
        @sub1 = @sub1 + item
      end
      
      @subcategories2 = Subcategory.where(category_id: 2)
      @sub2 = '"---"'
      @subcategories2.each do |sub|
        item = ',"' + sub.name + '"'
        @sub2 = @sub2 + item
      end
    
      @subcategories3 = Subcategory.where(category_id: 3)
      @sub3 = '"---"'
      @subcategories3.each do |sub|
        item = ',"' + sub.name + '"'
        @sub3 = @sub3 + item
      end
    
      @subcategories4 = Subcategory.where(category_id: 4)
      @sub4 = '"---"'
      @subcategories4.each do |sub|
        item = ',"' + sub.name + '"'
        @sub4 = @sub4 + item
      end
      
      render :new
    end
  end
  
  def index
    @communities = Community.all
  end
  
  def show
    #@community = Community.find(params[:id]) #fullcalendar コミュニティ毎のイベント表示
    #@events = @community.events
  end
  
  def community_show
    @community_show_modal = Community.find(params[:id])
    @cp_current_user = @community_show_modal.community_participants.find_by(user_id: current_user.id)
  end
  
  def community_edit
    @community_edit_modal = Community.find(params[:id])
    
    @subcategories1 = Subcategory.where(category_id: 1)
    @sub1 = '"---"'
    @subcategories1.each do |sub|
      item = ',"' + sub.name + '"'
      @sub1 = @sub1 + item
    end
      
    @subcategories2 = Subcategory.where(category_id: 2)
    @sub2 = '"---"'
    @subcategories2.each do |sub|
      item = ',"' + sub.name + '"'
      @sub2 = @sub2 + item
    end
    
    @subcategories3 = Subcategory.where(category_id: 3)
    @sub3 = '"---"'
    @subcategories3.each do |sub|
      item = ',"' + sub.name + '"'
      @sub3 = @sub3 + item
    end
    
    @subcategories4 = Subcategory.where(category_id: 4)
    @sub4 = '"---"'
    @subcategories4.each do |sub|
      item = ',"' + sub.name + '"'
      @sub4 = @sub4 + item
    end
  end
  
  def update
    @community_edit_modal = Community.find(params[:community][:id])
    if @community_edit_modal.category == 5 # [その他]
      @community_edit_modal.subcategory = 43 # [その他]
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
      params.require(:community).permit(:communityName, :category, :subcategory, :prefecture, :sex, :scale, :images, :description)
    end
end