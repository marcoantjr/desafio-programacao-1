FactoryGirl.define do
  factory :user do
    name "Garrosh Hellscream"
    email { Faker::Internet.email }
    password "grommash"
  end
end