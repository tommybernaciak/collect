class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :name, :string
    add_column :users, :country, :string
    add_column :users, :about, :text
    add_column :users, :age, :integer
  end
end
