class Payment < ActionMailer::Base
  include Resque::Mailer
  default from: "kristian@usefilter.com"
end
