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
  end
end

