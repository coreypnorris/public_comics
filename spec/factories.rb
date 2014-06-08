FactoryGirl.define do
  factory :genre do
    sequence(:name) { |n| "Genre #{n}" }
  end

  factory :title do
    genre
    sequence(:name) { |n| "Title #{n}" }
  end

  factory :issue do
    title
    number 1
    sequence(:cover) { |n| "comic_cover_url#{n}" }
  end

  factory :page do
    issue
    sequence(:image) { |n| "comic_image_url#{n}" }
    number 1
  end

end
