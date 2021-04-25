class NotificationsController < ApplicationController
  def index
  end
  def update
      puts params
      @notification = Notification.find(params[:id])
      @notification.viewed = true
      if @notification.save
          res = {success: true}
          render json: res.to_json
      else
          res = {success: false}
          render json: res.to_json
      end
  end

  # private
  # def notification_params
  #   params.require(:article).permit()
  # end
end
