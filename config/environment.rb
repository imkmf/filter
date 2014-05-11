# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Filter::Application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: ENV["MANDRILL_USER"],
  password: ENV["MANDRILL_PASS"],
  domain: 'usefilter.com',
  address: 'smtp.mandrillapp.com',
  port: 587,
  enable_starttls_auto: true,
  authentication: 'login',
}

