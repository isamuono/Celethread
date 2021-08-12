class EventsController < ApplicationController
  before_action :login_check
  
  def new
    @event = Event.new
    @event.community_id = params[:community_id]
    @event.channel_id = params[:channel_id]
    @event.color = params[:color]
  end
  
  def index
    # fullcalendar コミュニティ毎のイベント表示
    @community = Community.find(params[:id])
    @events = @community.events
  end
  
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    
    if @event.daterange == false && @event.allday == true
      @event.startdate = params[:event][:alldaydate]
      @event.enddate = nil
    elsif @event.daterange == false && @event.allday == false
      @event.startdate = params[:event][:alldaydate] + params[:event][:starttime1]
      @event.enddate = params[:event][:alldaydate] + params[:event][:endtime1]
    elsif @event.daterange == true && @event.allday == true
      @event.startdate = event_params[:startdate]
      @event.enddate = event_params[:enddate] + "24:00:00" # 選択した日付の00:00、つまり前日の24:00に指定されてしまうため
    elsif @event.daterange == true && @event.allday == false
      @event.startdate = event_params[:startdate] + params[:event][:starttime2]
      @event.enddate = event_params[:enddate] + params[:event][:endtime2]
    end
    
    @thread = Gthread.new
    @thread.user_id = current_user.id
    @thread.channel_id = @event.channel_id
    @thread.title = @event.title
    @thread.description = @event.description
    @thread.images = @event.images
    
    result = true
    if @thread.save
      @event.gthread_id = @thread.id
      if @event.save
        @thread.event_id = @event.id
        if !@thread.save
          result = false
        end
      else
        result = false
      end
    else
      result = false
    end
    
    if result
      redirect_to channels_gthreads_path(@event.channel_id), success: 'イベントを作成しました'
    else
      flash.now[:danger] = "イベント作成に失敗しました"
      render :new
    end
  end
  
  def show # カレンダーページのイベント情報の閲覧に必要なアクション
  end
  
  private
    def event_params
      params.require(:event).permit(:community_id, :channel_id, :title, :place, :startdate, :enddate, :daterange, :allday, :color, :description, { images: [] })
    end
end
