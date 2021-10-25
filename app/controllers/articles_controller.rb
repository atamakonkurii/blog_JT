class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show ]
  before_action :set_article, only: %i[ show edit update destroy translate_content]
  after_action :translate_contents, only: %i[ create update ], if: -> { @article.published? }

  # GET /articles or /articles.json
  def index
    @articles = Article.visible.published.recent.page(params[:page]).per(Article::PER_PAGE)
    # @tags = Article.tag_counts_on_locale(@locale).order('count DESC').limit(30)
    @articles = Article.published.visible.recent.tagged_with(params[:tag_name].to_s).distinct.page(params[:page]).per(Article::PER_PAGE) if params[:tag_name]
  end

  # GET /articles/1 or /articles/1.json
  def show
    @user = @article.user
    @tags = @article.tag_counts_on_locale(@locale)
    @articles = Article.visible.published.where.not(id: @article.id).order("RAND()").limit(3)
    return if browsing_authority?

    flash[:notice] = "この記事を閲覧する権限がありません"
    redirect_to user_path(@user)
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

    if params[:publish]
      @article.status = "published"
      notice = t('helpers.message.create')
    elsif params[:draft]
      @article.status = "draft"
      notice = t('helpers.message.draft')
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: notice }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    if params[:publish]
      @article.status = "published"
      notice = t('helpers.message.update')
    elsif params[:draft]
      @article.status = "draft"
      notice = t('helpers.message.draft')
    end

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: notice }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @user = @article.user
    if @user != current_user
      flash[:notice] = "この記事を削除する権限がありません"
      redirect_to article_path(@article)
    else
      @article.destroy
      respond_to do |format|
        format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
        format.json { head :no_content_ja }
      end
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
    params.require(:article).permit(:title_ja, :content_ja, :title_zh_tw, :content_zh_tw, :title_image, :japan_tag_list,
                                    :taiwan_tag_list,
                                    place_attributes: [:id, :country, :prefecture_japan_id, :prefecture_taiwan_id])
  end

  def translate_contents
    @article.translate_title_and_content
    @article.update(article_params)
  end

  def browsing_authority?
    @article.published? || @article.draft? && current_user == @user
  end
end
