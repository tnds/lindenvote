class User < ActiveRecord::Base
  acts_as_voter
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :password, :password_confirmation, :remember_me, :username, :role
  # attr_accessible :title, :body
  
  attr_accessor :login
  
  validates :username, :presence => true, :uniqueness => true
  validates :role, :presence => true, :inclusion => { :in => %w(user admin), :message => "%{value} is not a valid role" } # TODO: add i18n meesage
  
  has_many :topics
  
  before_validation :set_default_role, :on => :create

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  private
  def set_default_role
    self.role ||= "user"
  end
end
