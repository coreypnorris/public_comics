FactoryGirl.define do
  factory :genre do
    name { Faker::Name.name }
  end

  factory :title do
    genre
    name { Faker::Name.name }
  end

  factory :issue do
    title
    number { Faker::Number.number(3) }
    cover { Faker::Company.logo }
  end

  factory :page do
    issue
    image { Faker::Company.logo }
    number 1
  end

  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'foobarbaz'
    password_confirmation 'foobarbaz'
  end

  factory :comment do
    user
    body { Faker::Lorem.sentence }
  end
end
