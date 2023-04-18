FactoryBot.define do
  factory :comment do
    content { 'これはコメントです。' }
    association :user
    association :flower
  end
end