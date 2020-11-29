class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: {in: 2..20}
  validates :introduction, length: {maximum: 50}

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book
  
  attachment :profile_image
  
  # フォロー機能↓
  # 自分がフォローしてるユーザとの関連
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  # 自分がフォローされてるユーザーとの関連
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  
  # 通知機能↓
  has_many :active_notifications, class_name: "Notification", foreign_key: :visitor_id, dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: :visited_id, dependent: :destroy
  # 通知機能ここまで
  
  # トーク機能
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
  
  # フォロー機能↓
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end
