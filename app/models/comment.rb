class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  belongs_to :parent, class_name: "Comment" , optional: true
  has_many :comments, foreign_key: :parent_id , dependent: :destroy
  
  validates :body, presence: true,  allow_blank: false

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  private

  def notify_recipient
    CommentNotification.with(comments: self, blog: blog).deliver_later(blog.user)
  end

  def cleanup_notifications
    notifications_as_comment.destroy_all
  end
end
