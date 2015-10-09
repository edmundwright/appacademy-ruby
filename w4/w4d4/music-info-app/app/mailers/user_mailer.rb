class UserMailer < ApplicationMailer
  default from: "MusicInfo.com <notifications@musicinfo.com>"

  def activation_email(user)
    @user = user
    mail(
      to: "Loyal MusicInfo customer <#{user.email}>",
      subject: "MusicInfo activation email"
    )
  end
end
