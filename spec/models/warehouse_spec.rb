require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do #teste de validação de dados
    context 'presence' do
        it 'false when name is empty' do
            #Arrange
            warehouse = Warehouse.new(name: '', code: 'COD', city: 'Cidade', address: 'Endereço, 2', 
                area: 10_000, description: 'Alguma descrição.', zipcode: '0000000')
                #não é necessário salvar, validação ocorre antes de salvar itens.

            #Act
            result = warehouse.valid?
            #acionar método que está sendo testado

            #Assert
            expect(result).to eq false
            end

        it 'false when code is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'name', code: '', city: 'Cidade', address: 'Endereço, 2', 
                area: 10_000, description: 'Alguma descrição.', zipcode: '0000000')

            #Act
            result = warehouse.valid?

            #Assert
            expect(result).to eq false
            end

        it 'false when city is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'name', code: 'COD', city: '', address: 'Endereço, 2', 
                area: 10_000, description: 'Alguma descrição.', zipcode: '0000000')

            #Act
            result = warehouse.valid?

            #Assert
            expect(result).to eq false
            end

        it 'false when address is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Nome', code: 'COD', city: 'Cidade', address: '', 
                area: 10_000, description: 'Alguma descrição.', zipcode: '0000000')

            #Act
            result = warehouse.valid?

            #Assert
            expect(result).to eq false
            end

        it 'false when area is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Nome', code: 'COD', city: 'Cidade', address: 'endereço, 2', 
                area: '', description: 'Alguma descrição.', zipcode: '00000-000')

            #Act
            result = warehouse.valid?

            #Assert
            expect(result).to eq false
            end

        it 'false when description is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Nome', code: 'COD', city: 'Cidade', address: 'endereço, 2', 
                area: 10_000, description: '', zipcode: '0000000')

            #Act
            result = warehouse.valid?

            #Assert
            expect(result).to eq false
            end
        it 'false when zipcode is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Nome', code: 'COD', city: 'Cidade', address: 'endereço, 2', 
                area: 10_000, description: 'Alguma descrição.', zipcode: '')

            #Act
            result = warehouse.valid?

            #Assert
            expect(result).to eq false
            end
        
    end
    
    context 'uniqueness' do
    it 'false when name is already in use' do
        #Arrange
        first_warehouse = Warehouse.create(name: 'name1', code: 'RIO', city: 'Cidade1', address: 'Endereço, 1', 
            area: 10_000, description: 'Alguma descrição1.', zipcode: '00000000')

        second_warehouse = Warehouse.create(name: 'name1', code: 'COD', city: 'Cidade2', address: 'Endereço, 2', 
        area: 20_000, description: 'Alguma descrição2.', zipcode: '00000000')

        #Act
        result = second_warehouse.valid?

        #Assert
        expect(result).to eq false
        end

    it 'false when code is already in use' do
        #Arrange
        first_warehouse = Warehouse.create(name: 'name1', code: 'RIO', city: 'Cidade1', address: 'Endereço, 1', 
            area: 10_000, description: 'Alguma descrição1.', zipcode: '00000000')
        
        second_warehouse = Warehouse.create(name: 'name2', code: 'RIO', city: 'Cidade2', address: 'Endereço, 2', 
        area: 20_000, description: 'Alguma descrição2.', zipcode: '11111111')
        
        #Act
        result = second_warehouse.valid?
        
        #Assert
        expect(result).to eq false
        end
    end

    context 'length' do
    it 'false when zipcode is too short' do
        #Arrange
        warehouse = Warehouse.new(name: 'name1', code: 'RIO', city: 'Cidade1', address: 'Endereço, 1', 
            area: 10_000, description: 'Alguma descrição1.', zipcode: '000000')

        #Act
        result = warehouse.valid?

        #Assert
        expect(result).to eq false
        end
    end 
end
end