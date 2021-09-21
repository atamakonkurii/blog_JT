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

    target_text = "卵かけご飯"

    response = translate_client.translate_text({
                                                 text: target_text,
                                                 source_language_code: "ja",
                                                 target_language_code: "zh-TW",
                                               })
    puts response.translated_text
  end
end
