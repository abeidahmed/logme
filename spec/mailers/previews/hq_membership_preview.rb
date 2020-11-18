# Preview all emails at http://localhost:3000/rails/mailers/hq_membership
class HqMembershipPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/hq_membership/invite
  def invite
    HqMembershipMailer.invite
  end

end
