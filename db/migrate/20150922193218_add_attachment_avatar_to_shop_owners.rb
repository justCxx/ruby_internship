class AddAttachmentAvatarToShopOwners < ActiveRecord::Migration
  def self.up
    change_table :shop_owners do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :shop_owners, :avatar
  end
end
