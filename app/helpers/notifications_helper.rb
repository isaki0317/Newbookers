module NotificationsHelper
  
  def notification_form(notification)
    @visitor = notification.visitor
    @post_comment = nil
    your_book = link_to 'あなたの投稿', book_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.post_comment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"があなたをフォローしました"
      when "favolite" then
        tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:book_path(notification.book_id), style:"font-weight: bold;")+"にいいねしました"
      when "post_comment" then
        @post_comment = Comment.find_by(id: @visitor_comment)&.content
        tag.a(@visitor.name, href:users_user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:book_path(notification.book_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end
  
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

  
end
