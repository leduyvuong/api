class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.decimal :price
      t.references :category, null: false, foreign_key: true
      t.text :description
      t.integer :status
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end
  end
end
