# == Schema Information
#
# Table name: articles
#
#  id            :bigint           not null, primary key
#  content_en    :text(65535)
#  content_ja    :text(65535)
#  content_zh_tw :text(65535)
#  main_language :integer          not null
#  status        :integer          default("published"), not null
#  title_en      :string(255)
#  title_image   :string(255)
#  title_ja      :string(255)
#  title_zh_tw   :string(255)
#  visible_list  :boolean          default(TRUE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer          not null
#
require 'rails_helper'

RSpec.describe Article, type: :model do
  it "localeが日本の時日本語のコンテンツを返す" do
    locale = 'ja'
    article = Article.new(
      content_ja: "日本語",
      content_zh_tw: "台湾語"
    )

    expect(article.locale_judge_content(locale)).to eq "日本語"
  end
end
