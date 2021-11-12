class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.date :date_of_birth
      t.text :address
      t.string :phone
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
