class Comment < ApplicationRecord
  belongs_to :user 
  belongs_to :commentable, polymorphic: true
  has_many :comments, dependent: :destroy, as: :commentable
  
  validates :body, presence: true,  allow_blank: false

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  private

  def notify_recipient
    blog = commentable if commentable_type == 'Blog'
    CommentNotification.with(comments: self, blog: blog).deliver_later(blog.user) if blog
  end

  def cleanup_notifications
    notifications_as_comment.destroy_all
  end
end
