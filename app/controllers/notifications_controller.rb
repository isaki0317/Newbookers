class NotificationsController < ApplicationController
  
  def index
    #ログインユーザーへの通知を全て代入(自身で自身の投稿にいいねした通知は)
    @notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id)
    #whereで未読の通知のみに絞る？ブロック変数に代入してeach処理
    @notifications.where(checked: false).each do |notification|
      #未読通知をchecked: trueにすることで既読にしている?
      notification.update_attributes(checked: true)
    end
  end
  
  def destroy_all
    #表示されている全ての通知を削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
  
end
