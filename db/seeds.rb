# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# Usuários
user1 = User.create!(name: 'Joana Silva', email: 'joanas@email.com', password: '123456')
user2 = User.create!(name: 'Pedro Almeida', email: 'pedro.almeida@email.com', password: '7891011')

# Warehouses
w1 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', address: 'Avenida Principal, 1000', area: 100_000, description: 'Galpão destinado para cargas internacionais', zipcode: '07150000')
w2 = Warehouse.create(name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', address: 'Av. Rio verde, 1049', area: 50_000, description: 'Galpão secundário localizado no interior do estado.', zipcode: '04700010')
w3 = Warehouse.create!(name: 'Galpão Principal Rio', code: 'SDU', city: 'Rio de Janeiro', address: 'Rua do Aeroporto, 150', area: 60_000, description: 'Galpão localizado dentro do Aeroporto principal.', zipcode: '01000500')

# Suppliers
s1 = Supplier.create!(corporate_name: 'Stella e Regina Transportes ME', brand_name:'SR Transportes', registration_number:'15152295000199', address:'Av. Condessa Elisabeth, 5500', city:'Bauru', state:'SP', email:'producao@stellaereginatransportesme.com.br', phone: '1127199140')
s2 = Supplier.create!(corporate_name: 'ACME Industria Ltda.', brand_name:'ACME ltda', registration_number:'75443709000160', address:'Rua Pamplona, 1083', city:'São Paulo', state:'SP', email:'contato@acme.com', phone: '1124384557')
s3 = Supplier.create!(corporate_name: 'Gran RM Marcenaria ltd.', brand_name:'GRM Marcenaria', registration_number:'26231202000555', address:'Avenida Independência, 477', city:'Aparecida de Goiania', state:'GO', email:'diretoria@grmltda.com.br', phone: '6227950413')

# Product models
pm1 = ProductModel.create!(name:'Smartphone AS20', weight: 15000, width: 6, height: 19, depth: 2, sku:'CEL20-SAMASDS-AWEF5', supplier: s2)
pm2 = ProductModel.create!(name:'TV 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, sku:'TV32-SAMSGRS-SGHU2', supplier: s2) 
pm3 = ProductModel.create!(name:'TV 40 polegadas HD', weight: 9500, width: 90, height: 55, depth: 10, sku:'TV40-SAMSGRS-SGHU2', supplier: s2)
pm4 = ProductModel.create!(name:'Geladeira 2 portas', weight: 90000, width: 150, height: 190, depth: 120, sku:'GERA22-450DE-SGH50', supplier: s3)
pm5 = ProductModel.create!(name:'Fogão 4 bocas', weight: 12000, width: 90, height: 150, depth: 120, sku:'FGAO22-450DE-SGH50', supplier: s1)

# Orders
o1 = Order.create!(user: user1, warehouse: w1, supplier: s1, estimated_delivery_date: 1.week.from_now)
o2 = Order.create!(user: user1, warehouse: w2, supplier: s2, estimated_delivery_date: 1.month.from_now)
o3 = Order.create!(user: user2, warehouse: w3, supplier: s2, estimated_delivery_date: 1.year.from_now)
o4 = Order.create!(user: user2, warehouse: w2, supplier: s2, estimated_delivery_date: 1.year.from_now)
o5 = Order.create!(user: user1, warehouse: w2, supplier: s3, estimated_delivery_date: 1.year.from_now)
