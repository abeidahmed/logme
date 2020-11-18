class HqMembershipMailer < ApplicationMailer
  def invite(user, headquarter, new_user:)
    @user         = user
    @headquarter  = headquarter
    @new_user     = new_user

    mail to: user.email, subject: "You have an invitation to #{headquarter.name}"
  end
end
