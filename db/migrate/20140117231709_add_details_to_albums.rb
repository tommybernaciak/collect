class AddDetailsToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :year, :integer
    add_column :albums, :label, :string
    add_column :albums, :country, :string
    add_column :albums, :details, :text
    add_column :albums, :release, :string
  end
end
