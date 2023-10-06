FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { 'testuser@example.com' }
    posts_counter { 0 }
    # ... other attributes
  end
end
