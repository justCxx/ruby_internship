class ShopOwner < ActiveRecord::Base
  has_one :user, as: :account, dependent: :destroy

  has_many :products, foreign_key: :owner_id

  has_attached_file :avatar
end
