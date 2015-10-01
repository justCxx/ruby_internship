class Product < ActiveRecord::Base
  belongs_to :owner, class_name: "ShopOwner"

  validates :name, :description, presence: true

  has_attached_file :image, styles: { medium: "360x360", thumb: "100x100" },
                            default_url: "products/missing/:style/missing.png"
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
                               size: { in: 0..1.megabytes }

  after_initialize :set_pro, if: :new_record?

  def owned_by?(user)
    owner.user == user
  end

  def shop_name
    owner.shop_name
  end

  def self.for_guests
    Product.where(pro: false)
  end

  def set_pro
    self.pro = false
  end

  def can_purchase?
    !self.pro? && owner.shop_name.present?
  end
end
