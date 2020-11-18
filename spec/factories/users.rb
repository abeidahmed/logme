FactoryBot.define do
  factory :user do
    name { "John Doe" }
    sequence(:email) { |n| "johndoe#{n}@example.com" }
    password { "passwordsecret" }
    auth_token { "helloworld" }

    trait :forgot_password do
      password_reset_token { SecureRandom.urlsafe_base64 }
      password_reset_sent_at { Time.zone.now }
    end

    trait :with_expired_token do
      forgot_password
      password_reset_sent_at { 2.hours.ago }
    end
  end
end
