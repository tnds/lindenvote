class Poll < ActiveRecord::Base
  belongs_to :topic
  # attr_accessible :title, :body
  
  acts_as_votable
end
