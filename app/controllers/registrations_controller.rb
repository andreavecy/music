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



  private
  def sign_up_params
    params.require(:user).permit(:email, :password, :name, :last_name)
  end
end