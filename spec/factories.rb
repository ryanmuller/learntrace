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
    name        "Google"
    url         "http://google.com"
    description "search"
  end
end

