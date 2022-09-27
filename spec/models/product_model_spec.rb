require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do 
    context 'presence' do
      it 'false when name is empty' do
        #Arrange
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        pm = ProductModel.new(name:'', weight: 15000, width: 6, height: 19, depth: 2, 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier) # necessário supplier junto

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when sku is empty' do
        #Arrange
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        pm = ProductModel.new(name:'TV 32 polegadas', weight: 15000, width: 6, height: 19, depth: 2, 
        sku:'', supplier: pm_supplier) # necessário supplier junto

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when weight is empty' do
        #Arrange
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        pm = ProductModel.new(name:'TV 32 polegadas', weight: '', width: 6, height: 19, depth: 2, 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier)

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when width is empty' do
        #Arrange
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        pm = ProductModel.new(name:'TV 32 polegadas', weight: 15000, width: '', height: 19, depth: 2, 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier) # necessário supplier junto

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when height is empty' do
        #Arrange
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        pm = ProductModel.new(name:'TV 32 polegadas', weight: 15000, width: 6, height: '', depth: 2, 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier) # necessário supplier junto

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when depth is empty' do
        #Arrange
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        pm = ProductModel.new(name:'TV 32 polegadas', weight: 15, width: 6, height: 19, depth: '', 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier) # necessário supplier junto

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end

    end

    context 'uniqueness' do
      it 'false when sku is already used' do
        #Arrange
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        first_pm = ProductModel.create(name:'TV 32 polegadas', weight: 15000, width: 6, height: 19, depth: 5, 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier) # necessário supplier junto

        second_pm = ProductModel.create(name:'Celular S20', weight: 150, width: 8, height: 15, depth: 2, 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier) # necessário supplier junto

        #Act
        result = second_pm.valid?

        #Assert
        expect(result).to eq false
      end
    end

    context 'dimensions' do
      it 'false when weight is less than or equal to 0' do
        #Arrange
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        pm = ProductModel.new(name:'TV 32 polegadas', weight: 0, width: 6, height: 19, depth: 5, 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier) # necessário supplier junto

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when width is less than or equal to 0' do
        #Arrange
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        pm = ProductModel.new(name:'TV 32 polegadas', weight: 15000, width: -1, height: 19, depth: 5, 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier) # necessário supplier junto

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when height is less than or equal to 0' do
        #Arrange
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        pm = ProductModel.new(name:'TV 32 polegadas', weight: 15000, width: 6, height: -5, depth: 5, 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier) # necessário supplier junto

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end

      it 'false when depth is less than or equal to 0' do
        #Arrange
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        pm = ProductModel.new(name:'TV 32 polegadas', weight: 15000, width: 6, height: 19, depth: 0, 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier) # necessário supplier junto

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end
    end

    context 'length' do
      it 'when sku is too short' do
        pm_supplier = Supplier.create!(corporate_name: 'Samsung eletronicos BR', brand_name:'Samsung', registration_number:'55394009000160', address:'Rua Três de Maio, 1083', city:'Guarulhos', state:'SP', email:'contato@asamsung.com', phone: '1140044040')

        pm = ProductModel.new(name:'TV 32 polegadas', weight: 15000, width: 6, height: 19, depth: 0, 
        sku:'CEL20-SAMS-AWEF5', supplier: pm_supplier)

        #Act
        result = pm.valid?

        #Assert
        expect(result).to eq false
      end
    end


  end
end
