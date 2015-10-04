class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  belongs_to :account, polymorphic: true
  accepts_nested_attributes_for :account

  def build_account(params)
    if self.account_id?
      account.update_attributes(params)
    elsif account_type?
      self.account = account_type.constantize.new(params)
    end
  end
end
