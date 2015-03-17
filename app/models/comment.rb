# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  author_id        :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  body             :text             default(""), not null
#

class Comment < ActiveRecord::Base
  validates :commentable_id, :commentable_type, :author_id, presence: true
  validates :body, presence: { message: "Comment can't be blank" }
  validates :commentable_type, inclusion: { in: %w(User Goal) }

  belongs_to :commentable, polymorphic: true
end
