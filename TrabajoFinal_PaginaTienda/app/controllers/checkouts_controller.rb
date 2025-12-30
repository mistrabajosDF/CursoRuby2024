class CheckoutsController < ApplicationController
  before_action :set_cart
  
  def new
    @cart = current_cart
    @customer = current_customer
    @total = @cart.cart_items.sum { |item| item.product.price * item.quantity }
  end

  
  def create
    if @cart.cart_items.empty?
      redirect_to cart_path, alert: "Tu carrito está vacío."
      return
    end

    if params[:address].present?
      current_customer.update(address: params[:address])
    end

    total = @cart.cart_items.sum { |item| item.product.price * item.quantity }

    productos_json = @cart.cart_items.map do |item|
      {
        product_id: item.product.id.to_s,
        price: item.product.price.to_s,
        quantity: item.quantity.to_s
      }
    end

  begin
    state = params[:state] || true
    customer_name = params[:customer_name] || current_customer.name

    card_info = {
      number: params[:card_number],
      expiration: params[:expiration],
      cvv: params[:cvv]
    }
    
    sale = Sale.create_from_customer!(
      customer: current_customer,
      customer_name: customer_name,
      customer_id: current_customer.id, 
      total: total,
      products: productos_json,
      state: state
    )

    #Testea cuando rompe
  rescue ActiveRecord::RecordInvalid => e
    puts ">>> ERROR AL CREAR LA VENTA: #{e.message}"
    puts ">>> ERRORES DE VALIDACIÓN: #{e.record.errors.full_messages}"
    redirect_to cart_path, alert: "No se pudo completar la compra: #{e.record.errors.full_messages.join(', ')}"
    return
  end

    productos_json.each do |product_data|
      product = Product.find(product_data[:product_id])
      if product.stock >= product_data[:quantity].to_i
        product.stock -= product_data[:quantity].to_i
        product.save
      else
        redirect_to cart_path, alert: "No hay suficiente stock para el producto #{product.name}."
        return
      end
    end

    if sale.save
      @cart.cart_items.destroy_all
      redirect_to root_path, notice: "¡Compra realizada con éxito!"
    else
      redirect_to cart_path, alert: "Hubo un error al procesar tu compra."
    end
  end

  private

  def set_cart
    @cart = current_cart
  end
end

