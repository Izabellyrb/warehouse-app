class StockProductDestinationsController < ApplicationController
  before_action :authenticate_user!

  def create
    galpao = Warehouse.find(params[:warehouse_id])
    produto = ProductModel.find(params[:product_model_id])

    #encontrar UM, que o galpão e product_model sejam isso:
    stock_product = StockProduct.find_by(warehouse: galpao, product_model: produto)

    if stock_product != nil
      stock_product.create_stock_product_destination!(recipient:params[:recipient], address: params[:address])
      redirect_to galpao, notice: 'Item retirado com sucesso!'
    end

  end
end
