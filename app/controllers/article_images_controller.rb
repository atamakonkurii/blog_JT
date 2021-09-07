class ArticleImagesController < ApplicationController
  def create
    @image = ArticleImage.new({article_image: params[:article_image]})

    respond_to do |format|
      if @image.save
        format.html { render json: { name: @image.image.identifier, url: @image.image.url } }
        format.json { render json: { name: @image.image.identifier, url: @image.image.url } }
      end
    end
  end
end
