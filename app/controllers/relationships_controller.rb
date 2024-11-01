class RelationshipsController < ApplicationController
  before_action :set_user
  
  def create
    # modelで定義したメソッド使用
    current_user.follow(@user)
    # 同一ページに戻る
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(@user)
    redirect_to request.referer
  end
  
  def following
    @users = @user.following
  end
  
  def followers
    @users = @user.followers
  end
  
  private
  
  def set_user
    # ネストした親から持ってくる
    @user = User.find(params[:user_id])
  end
  
end
