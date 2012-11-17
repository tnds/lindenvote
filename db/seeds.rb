require "factory_girl_rails"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# user = User.create(:username => "user1", :email => "user1@example.com", :password => "123456", :role => "user")
# admin = User.create(:username => "admin", :email => "admin@example.com", :password => "123456", :role => "admin")
# topic = user.topics.build(:title => "Foo", :description => "Bar")
# topic.save
# pro_argument = topic.arguments.build(:title => "Foo", :description => "Bar", :sort => "pro", :user_id => user.id)
# pro_argument.save
# contra_argument = topic.arguments.build(:title => "Foo", :description => "Bar", :sort => "contra", :user_id => user.id)
# contra_argument.save

@user = FactoryGirl.create(:user, email: "user@example.com")
@admin = FactoryGirl.create(:admin, email: "admin@example.com")
200.times do
  @user.topics.create(FactoryGirl.attributes_for(:topic))
end

