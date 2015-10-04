class Admin < ActiveRecord::Base
  has_one :user, as: :account, dependent: :destroy

  has_attached_file :avatar
  has_attached_file :photo

  def self.notification_emails
    User.where(account_type: Admin).pluck(:email)
  end
end
