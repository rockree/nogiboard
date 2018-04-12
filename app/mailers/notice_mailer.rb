class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  default from: 'nogiboard_staff@nogizaka.jp'

  def sendmail_confirm(user)
    @user = user
    mail(to: "to@example.org", subject:'ユーザー登録ありがとうございました')
  end
end
