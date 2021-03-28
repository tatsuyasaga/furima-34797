FactoryBot.define do
  factory :order_address do
    postal_code     {"111-1111"}
    prefecture      { 2 }
    city            { "福岡" }
    address         { "1-1"}
    building_name   { "森ビル" }
    phone_number    { "11111111111" }
    token           { "0" }
  end
end