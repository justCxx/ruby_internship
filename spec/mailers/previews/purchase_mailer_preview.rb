# Preview all emails at http://localhost:3000/rails/mailers/purchase_mailer
class PurchaseMailerPreview < ActionMailer::Preview
  def user_notification
    image_url = "http://placehold.it/600/92c952"
    PurchaseMailer.user_notification(User.first, image_url)
  end

  def admins_notification
    PurchaseMailer.admins_notification("foo", 123)
  end
end
