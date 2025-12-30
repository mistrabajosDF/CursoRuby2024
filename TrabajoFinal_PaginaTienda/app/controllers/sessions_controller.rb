class SessionsController < ApplicationController

  before_action :check_user_active, only: [:create]

  def new
  end

  def create
    user = User.find_by(mail: params[:login]) || User.find_by(username: params[:login])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to products_path, notice: "#{user.name}, iniciaste sesión correctamente."
    else
      redirect_to login_path, alert: "El mail/usuario o la contraseña son incorrectos. Reintenta, por favor."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Has cerrado sesión correctamente."
  end  

  private

  def check_user_active
    user = User.find_by(mail: params[:login]) || User.find_by(username: params[:login])

    if user && user.state == false
      redirect_to login_path, alert: "Tu usuario no está activo, contacta con un administrador si crees que es un error."
    end
  end
end
