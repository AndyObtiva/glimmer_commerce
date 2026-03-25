class ProductsController < ApplicationController
  include PaginationHelper
  
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.limit(per_page).offset(page_offset)
    @products = @products.where('UPPER(name) like ?', "%#{params[:filter_product_name].upcase}%") if params[:filter_product_name].present?
    @products = @products.where(brand: params[:filter_product_brand]) if params[:filter_product_brand].present?
    @products = @products.where(gender: params[:filter_product_gender]) if params[:filter_product_gender].present?
    @products = @products.where(age: params[:filter_product_age]) if params[:filter_product_age].present?
    @products = @products.order("#{sort_attribute} #{sort_direction}") if sort_attribute.present?
    @page_count = (Product.count / per_page.to_f).ceil
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:brand_id, :name, :description, :price)
  end
end
