class HqMembershipMailer < ApplicationMailer
  def invite(user, headquarter, **options)
    @user         = user
    @headquarter  = headquarter
    @new_user     = options[:new_user]

    mail to: user.email, subject: "You have an invitation to #{headquarter.name}"
  end
end
