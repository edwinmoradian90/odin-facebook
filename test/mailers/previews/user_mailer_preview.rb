# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_creation
  def account_creation
    user = User.first
    UserMailer.account_creation(user)
  end

end
