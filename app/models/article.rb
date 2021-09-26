class Article < ApplicationRecord
  belongs_to :user
  has_one :place, dependent: :destroy
  accepts_nested_attributes_for :place

  has_many :tags, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum main_language: { japanese: 0, taiwanese: 1, english: 2 }

  mount_uploader :title_image, TitleImageUploader

  def translate_title_and_content
    translate_client = Aws::Translate::Client.new(
      region: "ap-northeast-1",
      access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
      secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
    )

    replace_tag = '<p translate=no>\&</p>'

    if main_language_japanese?
      target_title = title_ja
      # マークダウンの#と画像ファイルを翻訳しないようにする
      target_content = content_ja.gsub(/(^#+ )|(!\[file\]\().+\)/, replace_tag)
      source_language_code = "ja"
      target_language_code = "zh-TW"
    else
      target_title = title_zh_tw
      # マークダウンの#と画像ファイルを翻訳しないようにする
      target_content = content_zh_tw.gsub(/(^#+ )|(!\[file\]\().+\)/, replace_tag)
      source_language_code = "zh-TW"
      target_language_code = "ja"
    end

    response_title = translate_client.translate_text({
                                                       text: target_title,
                                                       source_language_code: source_language_code,
                                                       target_language_code: target_language_code
                                                     })

    response_content = translate_client.translate_text({
                                                         text: target_content,
                                                         source_language_code: source_language_code,
                                                         target_language_code: target_language_code
                                                       })

    # <p translate=no>とそれに紐づく</p>を削除
    translated_content = response_content.translated_text.gsub(%r{(<p translate=no>|</p>)}, '')

    if main_language_japanese?
      self.title_zh_tw = response_title.translated_text
      self.content_zh_tw = translated_content
    else
      self.title_ja = response_title.translated_text
      self.content_ja = translated_content
    end
  end

  private

  def main_language_japanese?
    main_language == "japanese"
  end
end
