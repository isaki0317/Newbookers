module NotificationsHelper
  
  #checked: false(未確認通知)の有無を判定するメソッド定義(今回はheaderのボタンでのif文で使用)
  def unchecked_notifications
    #未確認の通知を全て代入
    notifications=current_user.passive_notifications.where(checked: false)
    # 未読の全通知から自身の投稿に対する自身のコメントやいいねは除外して代入
    @notifications = notifications.where.not(visitor_id: current_user.id)
  end
  # _notification.html.erbで使用するhelperメソッドを定義
  def notification_form(notification)
    @comment=nil
    visitor=link_to notification.visitor.name, notification.visitor, style:"font-weight: bold;"
    #本の投稿がないユーザーだとbook.titleがnilになってエラーになるので条件分岐（オリジナル）
    unless notification.book.nil?
      your_post=link_to notification.book.title, book_path(notification.book), style:"font-weight: bold;"
    end
    case notification.action
      when "follow" then
        "#{visitor}があなたをフォローしました"
      when "favorite" then
        "#{visitor}が#{your_post}にいいね！しました"
      when "comment" then
        @comment=PostComment.find_by(id:notification.post_comment_id)
        "#{visitor}が#{your_post}にコメントしました"
      when "dm" then
        "#{visitor}からDMが届いています"
    end
  end
  
end
