class ApplicationController < ActionController::Base
  #after_filter :verify_authorized, :except => :index
include Pundit
rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
protect_from_forgery with: :exception

before_filter :set_locale


private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    #redirect_to request.headers["Referer"] || root_path
  end
end
