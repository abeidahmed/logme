class HqMembership
  module Filterable
    extend ActiveSupport::Concern

    module ClassMethods
      def filter_by_role(role)
        return self.all unless role.present?

        if role.downcase == "pending"
          pending_members
        else
          members_with_role(role.downcase)
        end
      end
    end
  end
end