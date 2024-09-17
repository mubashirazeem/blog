class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
  after_create :assign_default_role
  has_one_attached :image
  has_many :blogs , dependent: :destroy
  has_many :comments , dependent: :destroy

  has_many :notifications, as: :recipient, dependent: :destroy

  attr_accessor :stripe_customer_id


  def self.ransackable_attributes(auth_object = nil)
    super + %w[bio created_at email id remember_created_at reset_password_sent_at reset_password_token updated_at user_name]

  end
  
  def self.ransackable_associations(auth_object = nil)
    %w[roles]
  end
  
  def assign_default_role
    newbie_role = Role.find_or_create_by(name: 'newbie')
    add_role(:newbie) if self.roles.blank?
  end
end
