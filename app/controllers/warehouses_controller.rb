class WarehousesController < ApplicationController
  before_action :authenticate_user!
	before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

	def show
	end

	def new
			@warehouse = Warehouse.new
	end

	def create
			# criar novo galpão
			@warehouse = Warehouse.new(warehouse_params) 
			
			if @warehouse.save()
					#voltar para página inicial
					flash[:notice] = 'Galpão cadastrado com sucesso!'
					redirect_to root_url
			else
					flash.now[:notice] = 'Galpão não cadastrado!'
					render 'new'
			end 
	end

	def edit
	end

	def update
			if @warehouse.update(warehouse_params) #atualizar os parametros
					redirect_to warehouse_url(@warehouse.id)
					flash[:notice] = 'Galpão atualizado com sucesso!'
			else
					flash.now[:notice] = 'Não foi possível atualizar o galpão.'
					render 'edit'
			end
	end

	def destroy
			@warehouse.destroy
			redirect_to root_url 
			flash[:notice] = 'Galpão removido com sucesso!'
	end

	private
	def set_warehouse
			@warehouse = Warehouse.find(params[:id])
	end

	def warehouse_params
			params.require(:warehouse).permit(:name, :code, :city, :address, :area, :description, :zipcode) 
			#Strong parameters: filtrar infos q serão solic p usuario no form
	end

end