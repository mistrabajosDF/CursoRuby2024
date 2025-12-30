class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  rescue_from ActionController::RoutingError, with: :not_found

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in
    if current_user.nil?
      flash[:alert] = "Para ver lo solicitado debes iniciar sesión."
      redirect_to login_path
    end
  end

  def not_found
    render template: 'errors/not_found', status: 404
  end

  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :address, :phone, :name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :address, :phone, :name])
  end


  before_action :set_locale

  private

  def set_locale
    I18n.locale = :es
  end


  helper_method :current_cart

  def current_cart
    @current_cart ||= Cart.find_or_create_by(customer_id: current_customer.id)
  end

  
  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller? || is_tailwind_controller?
      "tailwind"
    else
      "application"
    end
  end

  def is_tailwind_controller?
    controller_name.in?(%w[carts checkouts])
  end

end
