FactoryBot.define do
  factory :user do
    name { "一般ユーザ" }
    email { "user@example.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
    admin { "false" }
  end

  factory :second_user, class: User do
    name { "管理者ユーザ" }
    email { "second_user@example.com" }
    password { "87654321" }
    password_confirmation { "87654321" }
    admin { "true" }
  end
end