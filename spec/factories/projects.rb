FactoryBot.define do
  factory :project do
    headquarter
    name { "Applog" }
    url { "https://goodquality.com" }
    sequence(:subdomain) { |n| "sub#{n}" }
    description { "good description" }
  end
end
