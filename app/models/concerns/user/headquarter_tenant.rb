class User
  module HeadquarterTenant
    def headquarter_owner?(headquarter)
      find_headquarter_membership(headquarter).owner?
    end

    def headquarter_invite_accepted?(headquarter)
      find_headquarter_membership(headquarter).invitation_accepted?
    end

    def headquarter_invite_pending?(headquarter)
      !find_headquarter_membership(headquarter).invitation_accepted?
    end

    def has_headquarter_membership?(headquarter)
      hq_memberships.exists?(headquarter_id: headquarter.id)
    end

    def find_headquarter_membership(headquarter)
      hq_memberships.find_by(headquarter_id: headquarter.id)
    end
  end
end