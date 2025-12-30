class UsersController < ApplicationController
  before_action :logged_in, only: [:index, :destroy, :new, :create, :edit, :update]
  before_action :require_admin_or_gerente, only: [:index, :new, :create]
  before_action :authorize_user_update, only: [:update]
  before_action :authorize_user_create, only: [:create]
  before_action :authorize_user_destroy, only: [:destroy]
  before_action :authorize_user_edit, only: [:edit]
  
  def index
    @users = User.where(state: true)
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def create
    @user = User.new(user_params)
    @user.state = true
    if @user.save
      redirect_to users_path, notice: "Usuario creado exitosamente."
    else
      @roles = Role.all
      flash[:alert] = "Hubo un error al crear el usuario. Prueba con otro mail o nombre de usuario."
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find_by(id: params[:id]) || current_user
    @roles = Role.all
  end

  def update
    @user = User.find_by(id: params[:id]) || current_user
    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: "El perfil ha sido actualizado."
    else
      flash[:alert] = "Hubo un error. Si modificaste el mail o nombre de usuario, prueba con otros valores, ya que no pueden repetirse."
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    @user = User.find_by(id: params[:id]) || current_user
    #ELIMINACION LOGICA
    random_value = SecureRandom.alphanumeric(8) 
    if @user.update(password: random_value, state: false)
      redirect_to users_path, notice: "El usuario ha sido desactivado."
    else
      redirect_to users_path, alert: "Hubo un error al desactivar el usuario."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :mail, :phone, :password, :state, :entrydate, :role_id)
  end

  def set_user
    @user = User.find_by(id: params[:id]) || current_user
  end

  def require_admin_or_gerente
    unless current_user.role.name == "Administrador" || current_user.role.name == "Gerente"
      flash[:alert] = "Ups, parece que quisiste entrar a una sección no permitida."
      redirect_to root_path
    end
  end

  def authorize_user_update
    @user = User.find_by(id: params[:id]) || current_user
    if current_user.role.name == "Gerente" && @user.role.name == "Administrador"
      redirect_to users_path, alert: 'No podes modificar un administrador.'
    end
  end

  def authorize_user_create
    @user = User.new(user_params)
    if current_user.role.name == "Gerente" && @user.role.name == "Administrador"
      redirect_to users_path, alert: 'No podes crear un administrador.'
    end
  end

  def authorize_user_destroy
    if current_user.role.name == "Gerente"
      redirect_to users_path, alert: 'No podés borrar a otro usuario.'
    end
  end

  def authorize_user_edit
    @user = current_user
    if current_user.role.name == "Empleado" && User.find_by(id: params[:id]) != current_user
      redirect_to edit_user_path(@user), alert: 'Error, parece que intentaste editar a otro usuario, solo podés modificar tu propio perfil.'
    end
  end
end

