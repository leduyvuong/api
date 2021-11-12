class Api::V1::OrdersController < ApplicationController
  before_action :found_orders, only: [:edit, :update, :show, :destroy, :changeType]
  def index
    type = params[:filter]
    @orders = []
    if type == "pending"
      @orders = Order.pending.paginate(page: params[:page])
    elsif type == "shipping"
      @orders = Order.shipping.paginate(page: params[:page])
    elsif type == "done"
      @orders = Order.done.paginate(page: params[:page])
    else
      @orders = Order.all.paginate(page: params[:page])
    end
    total = Order.all.count
    render json: {orders: @orders, total: total}
  end

  def changeType
    type = params[:type]
    if type == "pending"
      if @order.update(status: "shipping")
        render json: {success: true}
      else
        render json: {success: true, errors: @order.errors}
      end
    else type == "shipping"
      if @order.update(status: "done")
        render json: {success: true}
      else
        render json: {success: true, errors: @order.errors}
      end
    end
  end
  
  def checkProduct
    array = params[:list]
    product_string = []
    array.each do |prd|
      product = Product.find_by(id: prd[:product_id])
      if product
        if product.status == 0
          product_string << product.product_name + " đã hết hàng";
        end
      end
    end
    if !product_string.blank?
      render json: {stringProduct: product_string, success: false}
    else
      render json: {success: true}
    end
    
  end
  
  def create
    array = params[:list]
    order = Order.new(order_params)
    if (order_params[:user_id] != 2) 
      order.user_id = decode(order_params[:user_id])["user_id"]
    end
    order.total_money = caculateTotal(array)
    if order.save
      order_detail = []
      array.each do |prd|
        prdSingle = Product.find_by(id: prd[:product_id]) 
        if prdSingle
          prdSingle.update(status: 0)
          total_money = prd[:price].to_i * prd[:quantity].to_i
                order_detail << OrderDetail.new(order_id: order.id, 
          product_id: prd[:product_id].to_i, quantity: prd[:quantity].to_i,
          total_money: total_money)
        else
        end
      end
      OrderDetail.import order_detail
      render json: {success: true}
    else
      render json: {success: false, errors: order.errors}
    end
  end

  def show
    order_detail = @order.products
    orderList = @order.order_details
    orderIdList = Hash.new
    orderList.each do |ord|
      orderIdList["#{ord.product_id}"] = ord.id
    end
    @image = Hash.new;
    order_detail.each do |prd|
      @image["#{prd.id}"] = prd.getUrl(prd.images.first)
    end
    render json: {detail: order_detail, order: @order, image: @image, orderList: orderIdList}
  end

  def destroy
    @order.products.each do |prd|
      prd.update(status: 1)
    end
    if @order.destroy
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  private
    def caculateTotal(array)
      total = 0
      array.each do |prd|
        total += prd[:price].to_i * prd[:quantity].to_i
      end
      total
    end
    
    def order_params
      params.require(:infor).permit(:name, :address, :phone, :user_id)
    end

    def found_orders
      @order = Order.find_by(id: params[:id])
      if @order
        @order
      else
        render json: {errors: "Not found order"}
      end
    end
  
end
