class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.save
    render json: resource, status: :created
  end

  private
  def sign_up_params
    params.require(:user).permit(:email, :password, :name, :last_name)
  end
end