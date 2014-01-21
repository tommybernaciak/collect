class AddDetailsToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :for_sale, :boolean
    add_column :collections, :to_buy, :boolean
  end
end
