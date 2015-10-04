class PurchaseMailer < ApplicationMailer
  def user_notification(user, photo)
    @user = user
    @photo = photo
    mail(to: @user.email, subject: "Purchase successful")
  end

  def admins_notification(user_email, error_id)
    @user_email = user_email
    @error_id = error_id
    mail(to: Admin.notification_emails, subject: "Purchase error")
  end
end
