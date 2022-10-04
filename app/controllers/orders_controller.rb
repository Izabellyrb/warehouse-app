class OrdersController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_order, only: [:show, :edit, :update, :delivered, :canceled] 
  before_action :check_user, only: [:show, :edit, :update, :delivered, :canceled]
  
  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new()
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save 
      redirect_to @order
      flash[:notice] = 'Pedido registrado com sucesso!'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert] = 'Não foi possível registrar o pedido.'
      render :new
    end

  end

  def show
  end

  def search
    @code = params["query"]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end
  
  def update
    @order.update(order_params)
    redirect_to @order
    flash[:notice] = 'Pedido atualizado com sucesso!'
  end

  def delivered
    @order.delivered!
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end
  

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
        params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date) 
    end
    
    def check_user
      if @order.user != current_user
        return redirect_to root_url, alert: 'Você não tem permissão para acessar este pedido.'
      end
    end
end