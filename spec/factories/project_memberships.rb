FactoryBot.define do
  factory :project_membership do
    user
    project
    join_date { "2020-11-13 19:31:03" }
    invitation_accepted { true }
    job_title { "CEO" }
  end
end
