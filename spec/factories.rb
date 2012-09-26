FactoryGirl.define do
	factory :user do
		sequence(:username) {|n| "nick#{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
		password "123456"
		role "user"
		factory :admin do
		  role "admin"
		end
	end

  factory :topic do
    user
    sequence(:title) {|n| "Title #{n}"}
    sequence(:description) {|n| "Test #{n}"}
  end
  
  factory :argument do
    topic
    user
    sequence(:title) {|n| "Title #{n}"}
    sequence(:description) {|n| "Test #{n}"}
    factory :pro_argument do
      sort "pro"
    end
    factory :contra_argument do
      sort "contra"
    end
  end
end