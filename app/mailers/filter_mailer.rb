class FilterMailer < ActionMailer::Base
  include Resque::Mailer
  default from: "kristian@usefilter.com"

  def gave_email(email)
    @email = email
    @help = help_url
    mail(to: @email, subject: 'Thanks for joining Filter!')
  end

  def subscribed(user)
    @user = user
    mail(to: @user.email, subject: "You successfully signed up for Filter Pro!")
  end

  def new_subscription(user)
    @user = user
    mail(to: @user.email, subject: "Your free trial ends soon!")
  end

  def bad_payment(user)
    @user = user
    mail(to: @user.email, subject: "We had some problems with your payment...")
  end
end
