FactoryGirl.define do
  factory :goal do
    title Faker::Lorem.words(4).join(" ")
    body Faker::Lorem.sentence(5)
    author_id 1
    pub_status ([1,0].sample == 1 ? true : false)

    factory :completed_goal do
      completed true
    end

    factory :uncompleted_goal do
      completed false
    end
  end
end
