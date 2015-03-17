# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  user_id     :integer          not null
#  privacy     :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :string           default("in progress"), not null
#

class Goal < ActiveRecord::Base
  include Commentable

  validates :name, :user_id, :privacy, presence: true
  validates :privacy, inclusion: { in: %w(private public) }
  validates :status, inclusion: { in: ['in progress','complete'] }

  belongs_to :user

  def self.public_goals
    Goal.where(privacy: 'public')
  end
end
