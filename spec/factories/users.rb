FactoryBot.define do
  factory :user do
    name { "John Doe" }
    sequence(:email) { |n| "johndoe#{n}@example.com" }
    password { "passwordsecret" }
    auth_token { "helloworld" }
  end
end
