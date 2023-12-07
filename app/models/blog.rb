class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments , dependent: :destroy, as: :commentable
  
  has_one_attached :image
  has_rich_text :description
  validate :owner_can_delete, on: :destroy
  
  has_and_belongs_to_many :categories

  has_noticed_notifications model_name: "Notification"
  has_many :notifications, through: :user, dependent: :destroy
  
  def self.ransackable_attributes(auth_object = nil)
    %w[title description] # Add any other attributes you want to make searchable
  end

  def self.ransackable_associations(auth_object = nil)
    ["title", "description"]
  end
end
