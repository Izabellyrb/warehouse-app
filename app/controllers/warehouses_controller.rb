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
            redirect_to root_path
        else
            flash.now[:notice] = 'Galpão não cadastrado! Analise os dados e tente novamente.'
            render 'new'
        end 
    end
end