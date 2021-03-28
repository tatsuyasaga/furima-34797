FactoryBot.define do
  factory :item do
    name               { "日本酒" }
    price              { 300 }
    description        { Faker::Lorem.sentence }
    category_id        { 2 }
    items_condition_id { 2 }
    delivery_fee_id    { 2 }
    prefecture_id      { 2 }
    shipping_date_id   { 2 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open("public/images/test_image.png"), filename: "test_image.png")
    end
  end
end