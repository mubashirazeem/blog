class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments , dependent: :destroy
  
  has_one_attached :image
  has_rich_text :description
  validate :owner_can_delete, on: :destroy

  
  def self.ransackable_attributes(auth_object = nil)
    %w[title description] # Add any other attributes you want to make searchable
  end

  def self.ransackable_associations(auth_object = nil)
    ["title", "description"]
  end

  # def truncate_words(limit)
  #   description_plain_text = description&.description&.to_plain_text
  #   return if description_plain_text.nil?

  #   truncate_words(description_plain_text, length: limit)
  # end

  
end
