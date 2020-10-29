class Book < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  # 通知機能↓
  has_many :notifications, dependent: :destroy
  # ここまで
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  
  # notificationいいねとコメントのメソッド↓
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      book_id: id,
      visited_id: user_id,
      action: "favorite"
    )
    notification.save if notification.valid?
  end
  
  def create_notification_post_comment!(current_user, post_comment_id)
    temp_ids = PostComment.select(:user_id).where(book_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |book_id|
      save_notification_post_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    save_notification_post_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      book_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visited_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
