class ProductsController < ApplicationController
  include PaginationHelper
  include ProductsHelper
  
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
    filter_products
    @page_count = (@products.count / per_page.to_f).ceil
    @products = @products.order("#{sort_attribute} #{sort_direction}") if sort_attribute.present?
    @products = @products.limit(per_page).offset(page_offset)
    @products = ProductsSerializer.new(@products,
      per_page:, page:, page_count:,
      filter_product_name:, filter_product_brand:, filter_product_gender:, filter_product_age:,
      sort_attribute:, sort_direction:
    ).serializable_hash
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
  
  def filter_products
    @products = @products.where('UPPER(name) like ?', "%#{params[:filter_product_name].upcase}%") if params[:filter_product_name].present?
    if params[:filter_product_brand].present?
      brands = params[:filter_product_brand].split(',')
      @products = @products.where(brand: brands)
    end
    if params[:filter_product_gender].present?
      genders = params[:filter_product_gender].split(',')
      @products = @products.where(gender: genders)
    end
    if params[:filter_product_age].present?
      ages = params[:filter_product_age].split(',')
      @products = @products.where(age: ages)
    end
  end
end
