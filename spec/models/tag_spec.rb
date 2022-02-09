# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  taggings_count :integer          default(0)
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
