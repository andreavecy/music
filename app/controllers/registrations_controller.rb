class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(sign_up_params)
    if user.save
      render json: { msg: "Usuario creado", status: "OK" }
    else
      render json: { errors: "Revise los datos del usuario" }, status: :unprocessable_entity
    end
  end

  def update_user
    user = User.find(params[:id])
    if user.update(sign_up_params)
      render json: { msg: "usuario actualizado", user: user,status: "OK"}
    else
      render json: { error: "no se pudo actualizar el usuario"}, status: :unprocessable_entity
    end
  end



  private
  def sign_up_params
    params.require(:user).permit(:email, :password, :name, :last_name, :image)
  end
end