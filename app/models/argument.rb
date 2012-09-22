class Argument < ActiveRecord::Base
  acts_as_votable

  belongs_to :topic
  belongs_to :user
  attr_accessible :description, :title, :sort, :user_id, :topic_id
  
  validates :title, :description, :sort, :topic_id, :user_id, :presence => true
  validates :sort, :inclusion  => { :in => [ 'pro', 'contra' ], :message => "%{value} is not a valid argument sort" }
  
  def score
    self.upvotes.size - self.downvotes.size
  end
end
