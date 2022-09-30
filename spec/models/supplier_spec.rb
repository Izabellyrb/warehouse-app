require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do 
    context 'presence' do
      it 'false when corporate_name is empty' do
        #Arrange
        s = Supplier.new(corporate_name: '', brand_name:'ACME ltda', registration_number:'75443709000160', 
        address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

        #Act
        result = s.valid?

        #Assert
        expect(result).to eq false
      end
      it 'false when brand_name is empty' do
        #Arrange
        s = Supplier.new(corporate_name: 'ACME Industria Ltda.', brand_name:'', registration_number:'75443709000160', 
        address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

        #Act
        result = s.valid?

        #Assert
        expect(result).to eq false
      end
      it 'false when registration_number is empty' do
        #Arrange
        s = Supplier.new(corporate_name: '', brand_name:'ACME ltda', registration_number:'', 
        address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

        #Act
        result = s.valid?

        #Assert
        expect(result).to eq false
      end
      it 'false when email is empty' do
        #Arrange
        s = Supplier.new(corporate_name: '', brand_name:'ACME ltda', registration_number:'75443709000160', 
        address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'', phone: '1124384557')

        #Act
        result = s.valid?

        #Assert
        expect(result).to eq false
      end
    end

    context 'length' do
      it 'when registration_number is too short' do
        #Arrange
        s = Supplier.new(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'7544000160', 
        address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')

        #Act
        result = s.valid?

        #Assert
        expect(result).to eq false
      end
    end

    context 'uniqueness' do 
      it 'when registration_number is already in use' do
        # Arrange
        first_supplier = Supplier.create(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'111111', 
        address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')
      
        second_supplier = Supplier.create(corporate_name: 'Senna Telecomunicações ME', brand_name:'Senna Tel', registration_number:'111111', 
        address:'Rua Rui Barbosa, 921', city:'Volta Redonda', state:'RJ', email:'fiscal@sennatelecomunicacoes.com', phone: '2146301474')
      
        # Act
        result = second_supplier.valid?
          
        # Assert
        expect(result).to eq false
      end
      it 'when email is already in use' do
        # Arrange
          first_supplier = Supplier.create(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', 
          address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')
        
          second_supplier = Supplier.create(corporate_name: 'Senna Telecomunicações ME', brand_name:'Senna Tel', registration_number:'63965621000120', 
          address:'Rua Rui Barbosa, 921', city:'Volta Redonda', state:'RJ', email:'contato@acme.com', phone: '2146301474')
        
        # Act
          result = second_supplier.valid?
            
        # Assert
          expect(result).to eq false
      end
      it 'when phone is already in use' do
        # Arrange
          first_supplier = Supplier.create(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', 
          address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')
        
          second_supplier = Supplier.create(corporate_name: 'Senna Telecomunicações ME', brand_name:'Senna Tel', registration_number:'63965621000120', 
          address:'Rua Rui Barbosa, 921', city:'Volta Redonda', state:'RJ', email:'fiscal@sennatelecomunicacoes.com', phone: '1124384557')
        
        # Act
          result = second_supplier.valid?
            
        # Assert
          expect(result).to eq false
      end
    end
  end

  describe '#full_supplier' do
    it 'exibe o nome fantasia, razão social e CNPJ' do
    #Arrange
    user = User.new(name: 'Joana Silva', email:'joana.silva@email.com')

    #Act
    result = user.description

    #Assert
    expect(result).to eq('Joana Silva <joana.silva@email.com>')
    end
  end
  
end

