class Topic < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :title
  
  validates :title, :description, :user_id, :presence => true
  validates :title, :uniqueness => true
end
