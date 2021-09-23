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

    if main_language_japanese?
      target_title = title_ja
      target_content = content_ja
      source_language_code = "ja"
      target_language_code = "zh-TW"
    else
      target_title = title_zh_tw
      target_content = content_zh_tw
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

    if main_language_japanese?
      self.title_zh_tw = response_title.translated_text
      self.content_zh_tw = response_content.translated_text
    else
      self.title_ja = response_title.translated_text
      self.content_ja = response_content.translated_text
    end
  end

  private

  def main_language_japanese?
    main_language == "japanese"
  end
end
