include ActionDispatch::TestProcess

FactoryGirl.define do
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

  factory :genre do
    name { Faker::Name.name }
  end

  factory :title do
    genre
    name { Faker::Name.name }
  end

  factory :issue do |i|
    user
    title
    i.number { Faker::Number.number(3) }
    i.cover { fixture_file_upload( 'spec/factories/test_cover.jpg', 'image/jpg') }
    i.approved 1
  end

  factory :page do |p|
    issue
    p.image { fixture_file_upload( 'spec/factories/test_page.jpg', 'image/jpg') }
    p.number 1
  end
end
