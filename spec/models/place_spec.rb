# == Schema Information
#
# Table name: places
#
#  id                   :bigint           not null, primary key
#  country              :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  article_id           :integer          not null
#  prefecture_japan_id  :integer
#  prefecture_taiwan_id :integer
#
require 'rails_helper'

RSpec.describe Place, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
