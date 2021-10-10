namespace :add_value_to_column do
  desc "記事のstatusにpublishedのステータスを入れる"
  task add_article_status :environment do
    articles = Article.all
    articles.each do |article|
      article.published!
    end
  end
end
