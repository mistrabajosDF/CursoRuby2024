class ProductsController < ApplicationController
  before_action :logged_in, only: [:index, :show, :destroy, :new, :create, :edit, :update]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def price
    product = Product.find(params[:id])
    render json: { price: product.price }
  end
  
  def special_view
    #@products = Product.all
    @products = Product.where(state: true)

    # Filtro
    if params[:name].present?
      @products = @products.where("name LIKE ?", "%#{params[:name]}%")
    end

    if params[:description].present?
      @products = @products.where("description LIKE ?", "%#{params[:description]}%")
    end

    if params[:category_id].present? && params[:category_id].to_i != 0
      @products = @products.where(category_id: params[:category_id])
    end
  end

  def index
    #@products = Product.all
    @products = Product.where(state: true)

    # Filtro
    if params[:name].present?
      @products = @products.where("name LIKE ?", "%#{params[:name]}%")
    end

    if params[:description].present?
      @products = @products.where("description LIKE ?", "%#{params[:description]}%")
    end

    if params[:category_id].present? && params[:category_id].to_i != 0
      @products = @products.where(category_id: params[:category_id])
    end
  end

  def show
    @product = Product.find(params[:id])
    render json: { price: @product.price }
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Producto creado exitosamente."
      redirect_to products_path
    else
      render :new,  alert: I18n.t("products.create.failure")
    end
  end

  def edit
  end

  def update
    @product.state = true
    if @product.update(product_params)
      redirect_to products_path, notice: "La información del producto ha sido modificada."
    else
      render :edit, alert: "Ups, algo salió mal. Intenta de nuevo más tarde."
    end
  end

  def destroy
    #ELIMINACION LOGICA
    if @product.update(stock: 0, state: false)
      redirect_to products_path, notice: "El producto ha sido eliminado."
    else
      redirect_to products_path, alert: "Hubo un error al eliminar el producto."
    end
    #ELIMINACION FISICA
    #@product.destroy       
    #redirect_to products_url, notice: "El producto se borro de la bd."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :stock, :price, :talle, :color, :state, :category_id, :image)
   end

end
