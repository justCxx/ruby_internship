class Guest < ActiveRecord::Base
  has_one :user, as: :account, dependent: :destroy

  def can_buy?
    !user.email.end_with?(".com")
  end
end
