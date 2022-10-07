class OrderItemsController < ApplicationController
  before_action :set_order, only: [:new, :create] 

	def new
    @order_item = OrderItem.new()
    @products = @order.supplier.product_models # pedir ao fornecedor que puxe só os PMs deste fornecedor em específico
	end

  def create
    order_item_params = params.require(:order_item).permit(:product_model_id, :quantity)
    if @order.order_items.create(order_item_params)
      flash[:notice] = 'Item adicionado com sucesso!'
      redirect_to @order
    else
      flash[:notice] = 'Não foi possível adicionar item'
    end
  end
end

private
def set_order
  @order = Order.find(params[:order_id])
end

