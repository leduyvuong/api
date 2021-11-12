class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :total_money
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.text :address
      t.string :phone
      t.string :name

      t.timestamps
    end
  end
end
