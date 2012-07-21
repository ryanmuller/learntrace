FactoryGirl.define do
  factory :user do 
    sequence(:email) { |n| "john#{n}@doe.com" }
    password "password"
    password_confirmation "password"
  end

  factory :role do
    name "admin"
  end

  factory :item do
    sequence(:name) { |n| "Google #{n}" }
    url         "http://google.com"
    description "search"
  end

  factory :stream do
    sequence(:name) { |n| "Linear algebra #{n}" }
    user
  end

  factory :pin do
    user
    stream
    item

    trait :today do
      scheduled_at { Time.now }
    end

    trait :yesterday do
      scheduled_at { 1.day.ago }
    end

    trait :tomorrow do
      scheduled_at { 1.day.from_now }
    end

    trait :done do
      status "done"
    end

    trait :todo do
      status "todo"
    end

    factory :due_yesterday_pin, traits: [:yesterday, :todo]
    factory :due_today_pin, traits: [:today, :todo]
    factory :due_tomorrow_pin, traits: [:tomorrow, :todo]
    factory :completed_pin, traits: [:yesterday, :done]
    factory :completed_today_pin, traits: [:today, :done]
    factory :completed_early_pin, traits: [:tomorrow, :done]
  end
end

