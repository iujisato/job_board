class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_locale

rescue_from SlugError, :with => :rescue_from_slug_error


private
  def rescue_from_slug_error exception
  redirect_to exception.object
  end

  def current_company
    @current_company ||= if session[:company_id]
      Company.find_by_id(session[:company_id])
    end
  end
  helper_method :current_company

  def set_locale
    locale = params[:locale] || cookies[:locale]

    if locale.present?
      I18n.locale = locale
      cookies[:locale] = { value: locale, expires: 30.days.from_now }
    end
  end
  
end
