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
  scope :recent, -> { order(id: "DESC") }

  PER_PAGE = 9

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

    replace_tag = '<span translate=no>a123z</span>'

    if main_language_japanese?
      target_title = title_ja
      no_translate_array = no_translate_array_scan(content_ja)
      # マークダウンの#と画像ファイルを翻訳しないようにする
      target_content = content_ja.gsub(
        %r{(^#+ )|(!\[file\]\(.+\))|(<iframe.*</iframe>)|(<blockquote.*</blockquote>.<script async src="//www.instagram.com/embed.js"></script>)}, replace_tag
      )
      source_language_code = "ja"
      target_language_code = "zh-TW"
    else
      target_title = title_zh_tw
      no_translate_array = no_translate_array_scan(content_zh_tw)
      # マークダウンの#と画像ファイルを翻訳しないようにする
      target_content = content_zh_tw.gsub(
        %r{(^#+ )|(!\[file\]\(.+\))|(<iframe.*</iframe>)|(<blockquote.*</blockquote>.<script async src="//www.instagram.com/embed.js"></script>)}, replace_tag
      )
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
    translated_title = response_title.translated_text.gsub(%r{(<span translate=no>|</span>)}, '')
    translated_content = response_content.translated_text.gsub(%r{(<span translate=no>|</span>)}, '')

    no_translate_array.each do |text|
      translated_content.sub!(/a123z/, text)
    end

    @temp4 = translated_content

    if main_language_japanese?
      self.title_zh_tw = translated_title
      self.content_zh_tw = translated_content
    else
      self.title_ja = translated_title
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

    title.gsub(%r{(<span translate=no>|</span>)}, '')
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
    elsif language != 'ja' && main_language == "japanese"
      "※這篇文章是機器翻譯的句子"
    else
      ""
    end
  end

  private

  def main_language_japanese?
    main_language == "japanese"
  end

  def no_translate_array_scan(content)
    content.scan(%r{^#+ |!\[file\]\(.+\)|<iframe.*</iframe>|<blockquote.*</blockquote>.<script async src="//www.instagram.com/embed.js"></script>})
  end
end
