class CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart

def create
  product = Product.find(params[:product_id])
  item = @cart.cart_items.find_or_initialize_by(product: product)

  if item.new_record?
    item.quantity = params[:quantity].to_i
  else
    item.quantity += params[:quantity].to_i
  end

  if item.save
    redirect_to cart_path, notice: "Producto agregado al carrito."
  else
    redirect_to products_path, alert: "No se pudo agregar el producto."
  end
end

def update
  item = @cart.cart_items.find(params[:id])
  if item.update(cart_item_params)
    redirect_to cart_path, notice: "Cantidad actualizada."
  else
    redirect_to cart_path, alert: "No se pudo actualizar."
  end
end

def destroy
  item = @cart.cart_items.find(params[:id])
  item.destroy
  redirect_to cart_path, notice: "Producto eliminado del carrito."
end

private

def cart_item_params
  params.require(:cart_item).permit(:quantity)
end



  private

  def set_cart
    @cart = current_customer.cart
  end
end
