class ApplicationController < ActionController::Base
  include Authentication
  
  protect_from_forgery
  
  helper_method :current_user_session, :current_user, :require_admin_user
  
  before_filter :get_categories
  
  # global errors begin
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = I18n.t("flash.access_denied")
    redirect_to root_url
  end
  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    flash[:error] = I18n.t("flash.invalid_authtoken")
    redirect_to root_url
  end
  # global errors end
  
  private
  
  def get_categories
    @catalog_tree = Catalog.tree
  end

end
