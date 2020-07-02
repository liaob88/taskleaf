FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'テストを書くテストを書くテストを書く' }
    user
  end
end