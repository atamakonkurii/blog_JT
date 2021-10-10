class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:my_page, :edit, :update]

  def show
    @articles = if current_user == @user
                  @user.articles.visible.recent
                else
                  @user.articles.published.visible.recent
                end
  end

  def edit
    redirect_to user_path(@user) unless @user == current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def my_page
    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:name, :native_language, :avatar, :self_introduction, :facebook, :twitter,
                                   :instagram, :amazon)
  end
end
