FactoryGirl.define do
  factory :genre do
    name 'A Genre'
  end

  factory :title do
    sequence(:name) { |n| "Comic #{n}" }
    genre
  end

  factory :issue do
    number 1
    sequence(:cover) { |n| "comic_cover_url#{n}" }
    title
  end

end
