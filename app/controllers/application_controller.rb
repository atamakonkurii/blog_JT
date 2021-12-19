class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    I18n.locale = locale
  end

  def locale
    # 経路によってurlのパラメータが小文字になってしまうため強制的に変更する
    params[:locale] = "zh-TW" if params[:locale] == "zh-tw"
    @locale ||= params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    options.merge(locale: locale)
  end
end
