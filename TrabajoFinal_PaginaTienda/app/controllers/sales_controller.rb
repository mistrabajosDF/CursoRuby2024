class SalesController < ApplicationController
  before_action :logged_in, only: [:index, :show, :destroy, :new, :create, :edit, :update]
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  def index
    #@sales = Sale.all
    @sales = Sale.where(state: true)

    case params[:sale_type]
    when 'customer'
      @sales = @sales.where.not(customer_id: nil)
    when 'employee'
      @sales = @sales.where.not(user_id: nil)
    end
  end

  def show
  end

  def new
    @sale = Sale.new
  end

  def create
    products_data = JSON.parse(params[:sale][:products]) 
    products = []
    products_data.each do |product|
      product = {
        product_id: product["product_id"].to_s,
        price: product["price"].to_s,
        quantity: product["quantity"].to_s
      }
      products << product
      
    end

    if products == []
      redirect_to new_sale_path, alert: "Debes agregar al menos un producto."
      return
    end

    @sale = Sale.new(sale_params)
    @sale.user_id = current_user.id
    @sale.products = products

    @sale.products.each do |product_data|
      product = Product.find(product_data["product_id"])
      if product.stock >= product_data["quantity"].to_i
        product.stock -= product_data["quantity"].to_i
        product.save
      else
        redirect_to new_sale_path, alert: "No hay suficiente stock para el producto #{product.name}."
        return
      end
    end
    
    if @sale.save
      redirect_to sales_path, notice: 'Venta creada con éxito.'
    else
      render :new, alert: "Hubo un error al crear la venta."
    end
  end


  def create_from_customer
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    products_data = JSON.parse(params[:sale][:products])
    products = []

    products_data.each do |product|
      products << {
        product_id: product["product_id"].to_s,
        price: product["price"].to_s,
        quantity: product["quantity"].to_s
      }
    end

    if products.empty?
      redirect_to new_sale_path, alert: "Debes agregar al menos un producto."
      return
    end


    @sale = Sale.new(
      customer: current_customer,
      customer_name: customer_name,
      products: products,
      total: params[:sale][:total],
      state: true
    )

    ActiveRecord::Base.transaction do
      @sale.products.each do |product_data|
        product = Product.find(product_data["product_id"])
        cantidad = product_data["quantity"].to_i

        if product.stock >= cantidad
          product.update!(stock: product.stock - cantidad)
        else
          raise ActiveRecord::Rollback, "No hay suficiente stock para el producto #{product.name}."
        end
      end

      if @sale.save
        redirect_to sales_path, notice: 'Venta creada con éxito.'
      else
        render :new, alert: "Hubo un error al crear la venta."
      end
    end

  rescue => e
    redirect_to new_sale_path, alert: e.message
  end



  def edit
  end

  def update
  end

  def destroy
    @sale = Sale.find_by(id: params[:id])
    sale = @sale

    sale.products.each do |product_data|
      product = Product.find(product_data["product_id"])
      product.stock += product_data["quantity"].to_i
      product.save
    end

    if @sale.update(state: false)
      redirect_to sales_path, notice: "La venta seleccionada ha sido cancelada."
    else
      redirect_to sales_path, alert: "Hubo un error al cancelar la venta."
    end
  end

  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:customer, :state, :user_id, :total, :products, :customer_name, :customer_id)
  end

end
