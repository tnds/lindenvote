class Topic < ActiveRecord::Base
  acts_as_votable

  has_one :poll
  has_many :arguments
  
  belongs_to :user
  attr_accessible :description, :title
  
  after_create :create_poll
  
  validates :title, :description, :user_id, :presence => true
  validates :title, :uniqueness => true
  
  accepts_nested_attributes_for :arguments
  private
  
  def create_poll
    self.poll = Poll.create!
  end
end
