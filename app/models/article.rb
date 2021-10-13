class Article < ApplicationRecord
  belongs_to :user
  has_one :place, dependent: :destroy
  accepts_nested_attributes_for :place

  has_many :comments, dependent: :destroy

  enum main_language: { japanese: 0, taiwanese: 1, english: 2 }
  enum status: { published: 0, draft: 1 }

  mount_uploader :title_image, TitleImageUploader

  acts_as_taggable_on :japan_tags, :taiwan_tags

  scope :visible, -> { where(visible_list: true) }
  scope :recent, ->(limit=99) { order(id: "DESC").limit(limit) }

  def self.tag_counts_on_locale(language)
    if language == 'ja'
      tag_counts_on(:japan_tags)
    else
      tag_counts_on(:taiwan_tags)
    end
  end

  def tag_counts_on_locale(language)
    if language == 'ja'
      tag_counts_on(:japan_tags)
    else
      tag_counts_on(:taiwan_tags)
    end
  end

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
      target_content = content_ja.gsub(%r{(^#+ )|(!\[file\]\().+\)|(<iframe.*</iframe>)}, replace_tag)
      source_language_code = "ja"
      target_language_code = "zh-TW"
    else
      target_title = title_zh_tw
      # マークダウンの#と画像ファイルを翻訳しないようにする
      target_content = content_zh_tw.gsub(%r{(^#+ )|(!\[file\]\().+\)|(<iframe.*</iframe>)}, replace_tag)
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

  def locale_judge_title(language)
    title = case language
            when 'ja'
              title_ja
            else
              title_zh_tw
            end
    # contentがblankなら空白を返す
    return '' if title.blank?

    title
  end

  def locale_judge_content(language)
    content = case language
              when 'ja'
                content_ja
              else
                content_zh_tw
              end
    # contentがblankなら空白を返す
    return '' if content.blank?

    content
  end

  def display_translate_caution(language)
    if language == 'ja' && main_language == "taiwanese"
      "※この記事は機械翻訳された文章です"
    elsif language == 'zh-TW' && main_language == "japanese"
      "※這篇文章是機器翻譯的句子"
    else
      ""
    end
  end

  private

  def main_language_japanese?
    main_language == "japanese"
  end
end
