class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :content
      t.string :vi_content
      t.integer :count

      t.timestamps
    end
  end
end
