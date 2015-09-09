class UserMailer < ActionMailer::Base
  default from: "Spreads Football Picks <no-reply@spreads.com>"
  #layout "email"

  def pick_reminder(user, pool)
    @user = user
    @pool = pool
    attachments.inline['reminder.jpg'] = File.read('app/assets/images/reminder.jpg')
    attachments.inline['logo.png'] = File.read('app/assets/images/logo.png')
    mail(to: @user.email, subject: 'REMINDER: Make your football picks')
  end
end
