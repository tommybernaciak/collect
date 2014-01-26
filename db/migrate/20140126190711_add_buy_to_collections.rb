class AddBuyToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :buy, :boolean, default: false
  end
end
