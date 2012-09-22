FactoryGirl.define do
	factory :user do
		sequence(:username) {|n| "nick#{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
		password "123456"
		factory :admin do
		  admin true
		end
	end

  factory :topic do
    user
    sequence(:title) {|n| "Title #{n}"}
    sequence(:description) {|n| "Test #{n}"}
  end
end