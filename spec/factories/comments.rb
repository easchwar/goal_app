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

FactoryGirl.define do
  factory :comment do
    
  end

end
