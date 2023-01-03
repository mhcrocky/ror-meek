class ApplicationMailer < ActionMailer::Base
  include Resque::Mailer

  default from: ENV.fetch('MAIL_REPLY_TO')

  layout 'mailer'
end
