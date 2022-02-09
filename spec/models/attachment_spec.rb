# == Schema Information
#
# Table name: attachments
#
#  id            :bigint           not null, primary key
#  article_image :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Attachment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
