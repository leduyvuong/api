class Api::V1::ProductsController < ApplicationController
before_action :found_product, only: [:edit, :update, :show, :destroy]

  def index
    @products = Product.filter(params[:filter]).paginate(page: params[:page])
    @total = Product.filter(params[:filter]).count
    @image = Hash.new;
    @products.each do |prd|
      @image["#{prd.id}"] = prd.getUrl(prd.images.first)
    end
    render json: {lists: @products, totalProducts: @total, images: @image}
  end

  def new
    @categories = Category.all
    render json: @categories
  end
  
  def create
    @product = Product.new(product_params)
    @product.price = @product.price.to_i
    if @product.save
      @product.images.attach(params[:image1])
      @product.images.attach(params[:image2])
      render json: {success: true, image: @product.images}
    else
      render json: {success: false, errors: @product.errors}
    end
  end

  def destroy
    if @product.status == 1
      if @product.update(status: 0)
        render json: {success: true}
      else
        render json: {success: false}
      end
    else
      if @product.update(status: 1)
        render json: {success: true}
      else
        render json: {success: false}
      end
    end
  end

  def update
    if @product.update(product_params)
      if !@product.images.attached?
        @product.images.attach(params[:image1])
        @product.images.attach(params[:image2])
      end
      render json: {success: true}
    else
      render json: {success: false, errors: @product.errors}
    end
  end

  def show
    @products = Product.find_by(id: params[:id])
    image = []
    if @products
      if @products.images.attached?
        image << @products.getUrl(@products.images.first)
        image << @products.getUrl(@products.images.second)
      end
      @categories = Category.all
      render json: {product: @products, image: image, categories: @categories}
    else
      render json: {error: "Not found product"}
    end
  end

  private
  def found_product
    @product = Product.find_by(id: params[:id])
    if @product
      @product
    else
      render json: {error: "Not found product"}
    end
  end
  
  def product_params
    params.permit(:product_name, :price, :description, :category_id, :tag_id)
  end
  
  
end
