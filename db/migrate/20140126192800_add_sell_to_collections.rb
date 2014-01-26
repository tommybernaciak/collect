class AddSellToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :sell, :boolean, default: false
  end
end
