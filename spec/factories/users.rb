FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    last_name             { "山田" }
    last_name_kana        { "ヤマダ" }
    first_name            { "小太郎" }
    first_name_kana       { "コタロウ" }
    email                 { Faker::Internet.free_email }
    password              { "aaa111" }
    password_confirmation { password }
    birth_date            { "1987-09-27" }
  end
end