module Mailers
  module MailersHelper
    def last_email
      ActionMailer::Base.deliveries.last
    end
  end
end