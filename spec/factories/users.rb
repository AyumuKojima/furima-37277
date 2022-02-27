FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = "Test1230"
    password {password}
    password_confirmation {password}
    last_name {"山田やまだヤマダ"}
    first_name {"太郎たろうタロウ"}
    last_name_reading {"ヤマダ"}
    first_name_reading {"タロウ"}
    birthday {Date.new(1983, 07, 15)}
  end
end
