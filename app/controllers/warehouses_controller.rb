class WarehousesController < ApplicationController
    def show
        @warehouse = Warehouse.find(params[:id])
    end

    def new
        @warehouse = Warehouse.new
    end

    def create
        # criar novo galpão
        warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :address, :area, :description, :zipcode)
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
        @warehouse = Warehouse.find(params[:id])
    end

    def update
        @warehouse = Warehouse.find(params[:id])

        warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :address, :area, :description, :zipcode)

        if @warehouse.update(warehouse_params) #atualizar os parametros
            redirect_to warehouse_url(@warehouse.id)
            flash[:notice] = 'Galpão atualizado com sucesso!'
        else
            flash.now[:notice] = 'Não foi possível atualizar o galpão.'
            render 'edit'
        end
        
    end

end