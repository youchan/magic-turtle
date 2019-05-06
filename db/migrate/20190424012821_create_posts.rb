class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :guid, unique: true
      t.string :account_guid, null: false
      t.text :code, null: false
      t.text :image, null: false
      t.string :name
      t.boolean :open

      t.timestamps
    end
  end
end
