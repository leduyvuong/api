class Api::V1::OrderDetailsController < ApplicationController
  before_action :found_order_detail, only: [:edit, :update, :show, :destroy]
  def destroy
    total_money = @detail.order.total_money - @detail.total_money
    product = @detail.product
    if @detail.destroy
      @detail.order.update(total_money: total_money)
      product.update(status: 1)
      render json: {success: true}
    else
      render json: {success: false}
    end
  end
  
  private

  def found_order_detail
    @detail = OrderDetail.find_by(id: params[:id])
    if @detail
      @detail
    else
      render json: {erorrs: "Not found"}
    end
  end
  
end
