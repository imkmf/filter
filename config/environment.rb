# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Filter::Application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: Figaro.env.mandrill_user,
  password: Figaro.env.mandrill_pass,
  domain: 'usefilter.com',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}

