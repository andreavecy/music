class SessionsController < Devise::SessionsController
  respond_to :json

  def get_user
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.find_by_email(sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])

      render json: { msg: "Usuario Logeado", user: user, status: "OK" }
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def list_users
    users = User.order(:name) # Ordena por nombre

    # Filtro de búsqueda
    if params[:query].present?
      users = users.where("name ILIKE ?", "%#{params[:query]}%")
    end

    # Paginación
    users = users.page(params[:page]).per(params[:per_page] || 10)

    render json: {
      users: users,
      meta: {
        total_pages: users.total_pages,
        current_page: users.current_page,
        total_count: users.total_count
      }
    }
  end

  def find_user
    @users = User.where("name like ?", "%#{params[:q]}%")
    render json: @users
  end

  private

  def respond_with( resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end

end