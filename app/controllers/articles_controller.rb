class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show ]
  before_action :set_article, only: %i[ show edit update destroy]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
    @user = @article.user
  end

  # GET /articles/new
  def new
    @article = Article.new
    @article.build_place
  end

  # GET /articles/1/edit
  def edit
    @user = @article.user
    return if @user == current_user

    flash[:notice] = "この記事を編集する権限がありません"
    redirect_to article_path(@article)
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.main_language = current_user.native_language

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.title_image.purge if @article.title_image.present?
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content_ja }
    end
  end

  def attach
    attachment = Attachment.create!(article_image: params[:image])
    render json: { filename: attachment.article_image.url }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title_ja, :content_ja, :title_image,
                                      place_attributes: [:id, :country, :prefecture_japan_id, :prefecture_taiwan_id])
    end
end
