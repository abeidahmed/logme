FactoryBot.define do
  factory :hq_membership do
    user
    headquarter
    invitation_accepted { true }
    join_date { "2020-11-12 09:28:04" }
    role { "member" }

    trait :owner do
      role { "owner" }
    end

    trait :pending do
      invitation_accepted { false }
      join_date { nil }
    end

    trait :pending_owner do
      pending
      owner
    end
  end
end
