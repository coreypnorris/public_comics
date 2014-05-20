FactoryGirl.define do
  factory :genre do
    name 'A Genre'
  end

  factory :title do
    sequence(:name) { |n| "Comic #{n}" }
    genre
  end

end
