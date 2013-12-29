class AddProfilePhotoToUsers < ActiveRecord::Migration
  def self.up
    add_attachment :users, :profile_photo
  end

  def self.down
    remove_attachment :users, :profile_photo
  end
end
