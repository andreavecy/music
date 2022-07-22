class FollowsController < ApplicationController
  before_action :set_follow, only: %i[ show update destroy ]

  def follow
    @user = User.find(params[:followee_id])
    current_user = User.find(params[:id])
    current_user.followees << @user
    render json: {msg: "seguiste al usuario #{@user.name}"}
  end

  def unfollow
    @user = User.find(params[:followee_id])
    current_user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    render json: {msg: "dejaste de seguir al usuario #{@user.name}"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      @follow = Follow.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def follow_params
      params.permit(:follower_id, :followee_id)
    end
end
