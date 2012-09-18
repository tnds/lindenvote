FactoryGirl.define do
	factory :user do
		username "Nick"
    sequence(:email) {|n| "user#{n}@example.com"}
		password "123456"
	end

  
  factory :topic do
    user
    sequence(:title) {|n| "Title #{n}"}
    sequence(:description) {|n| "Test #{n}"}
  end
end