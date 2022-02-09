module Api
  module V1
    class ArticlesController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[ index ]
      before_action :set_article
      before_action :set_article_json

      def index
        render json: set_article_json
      end

      def set_article
        @articles = Article.all
      end

      def set_article_json
        serializer = ArticleSerializer.new(@articles)
        serializer.serializable_hash.to_json
      end
    end
  end
end
