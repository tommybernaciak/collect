class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :user_id
      t.integer :album_id

      t.timestamps
    end
    add_index :collections, :user_id
    add_index :collections, :album_id
    add_index :collections, [:user_id, :album_id], unique: true
  end
end
