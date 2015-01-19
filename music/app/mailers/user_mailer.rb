class UserMailer < ActionMailer::Base
  default from: "uglylyrics@uglysite.com"

  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Click on the link to authorize')
  end

end
