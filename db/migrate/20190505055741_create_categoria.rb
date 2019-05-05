class CreateCategoria < ActiveRecord::Migration[5.2]
  def change
    create_table :categoria do |t|
      t.string :nombre
      t.text :desc

      t.timestamps
    end
  end
end
