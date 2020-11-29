class RelationshipsController < ApplicationController
  
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    #通知の作成
    @user = follow.follower
    @user.create_notification_follow!(current_user)
    redirect_to users_path
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to users_path
  end
  
end
