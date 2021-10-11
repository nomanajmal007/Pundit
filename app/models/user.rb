class User < ApplicationRecord
  rolify
  has_many :portfolios, through: :roles, source: :resource, source_type:  :Portfolio
  has_many :creator_portfolios, -> { where(roles: {name: :creator}) }, through: :roles, source: :resource, source_type:  :Portfolio
  has_many :editor_portfolios, -> { where(roles: {name: :editor}) }, through: :roles, source: :resource, source_type:  :Portfolio


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates_presence_of:name
  validate :must_have_a_role, on: :update 

  after_create :assign_default_role


  def first_name
    self.name.split.first
  end

  def last_name
    self.name.split.last
  end

  def must_have_a_role
    unless roles.any?
      errors.add(:roles,"Must have at least 1 role")
    end
  end


  private
  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end


end