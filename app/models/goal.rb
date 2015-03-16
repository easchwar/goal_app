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
#

class Goal < ActiveRecord::Base
  validates :name, :user_id, :privacy, presence: true
  validates :privacy, inclusion: { %w(private public) }

  belongs_to :user
end
