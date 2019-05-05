class CreateProductos < ActiveRecord::Migration[5.2]
  def change
    create_table :productos do |t|
      t.string :nombre
      t.decimal :precio, precision: 8, scale: 2
      t.integer :categorium_id

      t.timestamps
    end
  end
end
