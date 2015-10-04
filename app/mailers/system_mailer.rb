class SystemMailer < ApplicationMailer
  def api_error_notification
    mail(to: Admin.notification_emails, subject: "API error")
  end
end
