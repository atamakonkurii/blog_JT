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
