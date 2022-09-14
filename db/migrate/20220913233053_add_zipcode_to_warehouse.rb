class AddZipcodeToWarehouse < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :zipcode, :string
  end
end
