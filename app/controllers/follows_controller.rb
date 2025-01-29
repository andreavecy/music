class FollowsController < ApplicationController
  before_action :set_followee, only: [:follow, :unfollow]

  # Acción para seguir a un usuario
  def follow
    current_user = User.find(params[:id]) # Usuario autenticado o enviado
    if current_user.followees.include?(@followee)
      render json: { msg: "Ya sigues a este usuario" }, status: :unprocessable_entity
    else
      current_user.followees << @followee
      render json: { msg: "Has seguido al usuario #{@followee.name}" }, status: :ok
    end
  end

  # Acción para dejar de seguir a un usuario
  def unfollow
    current_user = User.find(params[:id]) # Usuario autenticado o enviado
    follow = Follow.find_by(follower: current_user, followee: @followee)

    if follow
      follow.destroy
      render json: { msg: "Has dejado de seguir al usuario #{@followee.name}" }, status: :ok
    else
      render json: { msg: "No estás siguiendo a este usuario" }, status: :not_found
    end
  end

  private

  # Encuentra al usuario a seguir/dejar de seguir
  def set_followee
    @followee = User.find_by(id: params[:followee_id])
    render json: { msg: "El usuario no existe" }, status: :not_found unless @followee
  end
end
