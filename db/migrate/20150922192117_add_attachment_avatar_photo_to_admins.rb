class AddAttachmentAvatarPhotoToAdmins < ActiveRecord::Migration
  def self.up
    change_table :admins do |t|
      t.attachment :avatar
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :admins, :avatar
    remove_attachment :admins, :photo
  end
end
