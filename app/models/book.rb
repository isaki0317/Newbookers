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

end
