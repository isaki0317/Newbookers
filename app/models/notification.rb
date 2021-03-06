class Notification < ApplicationRecord
  
  default_scope->{order(create_at: :desc)}
  
  belongs_to :book, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true 
  # トーク機能への通知↓
  belongs_to :room, optional: true
  belongs_to :chat, optional: true
  
end
