class NotificationsController < ApplicationController
  def unchecked_notifications_present_check
    @unchecked_notifications = current_user.passive_notifications.where(checked: false)#.where.not(visitor_id: current_user.id)
  end
  
  def update
    @notification = Notification.find(params[:id])
    if @notification.checked == false
      @notification.update(checked: true)
    else
      @notification.update(checked: false)
    end
  end
end
