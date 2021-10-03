namespace :add_value_to_column do
  desc "記事一覧に表示するかしないかを設定するカラムにtrueを入れる"
  task add_visible_information_at_index: :environment do
    articles = Article.all
    articles.each do |article|
      article.update!(visible_list: true)
    end
  end
end
