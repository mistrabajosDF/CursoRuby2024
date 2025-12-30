class CartsController < ApplicationController
  before_action :authenticate_customer!

  def show
    @cart = current_customer.cart
  end

  def clear
    @cart = current_customer.cart
    @cart.cart_items.destroy_all
    redirect_to cart_path, notice: "Carrito vaciado."
  end
end


