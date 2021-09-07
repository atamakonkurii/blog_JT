module ApplicationHelper
  def i18n_url_for(options)
    if options[:locale] == I18n.default_locale
      options[:locale] = nil
    end
    url_for(options)
  end

  def cdn_ready_blob_path(attachment)
    service = Rails.application.config.active_storage.service
    case service
    when :local
      # 元々のヘルパ
      rails_blob_path(attachment)
    when :amazon
      # S3上でのファイル名を取得してURLを組み立てる
      key = attachment&.blob&.key
      "https://static.nittai-one.com/#{key}"
    end
  end
end
