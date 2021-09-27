module ApplicationHelper
  def i18n_url_for(options)
    if options[:locale] == I18n.default_locale
      options[:locale] = nil
    end
    url_for(options)
  end

  def default_meta_tags
    {
      site: '日台one!',
      title: '日台友好',
      reverse: true,
      charset: 'utf-8',
      description: '這是一個由日本台灣情侶經營的博客',
      keywords: '台日情侶',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      fb: {
        app_id: '4213439218770299'
      },
      twitter: {
        card: 'summary',
        site: '@atamakonkurii'
      }
    }
  end
end
