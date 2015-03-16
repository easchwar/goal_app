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

FactoryGirl.define do
  factory :goal do
    name "MyString"
description "MyText"
user_id 1
privacy "MyString"
  end

end
