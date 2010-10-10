class User::PasswordResetsController < User::BaseController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  before_filter :require_no_user
  
  
  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = I18n.t("user.flash.forgot_password_notice")
      redirect_to root_url
    else
      flash[:error] = I18n.t("user.flash.forgot_password_error")
      render :action => :new
    end
  end
  
  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = I18n.t("user.flash.edit_password_resets_notice")
      redirect_to account_url
    else
      render :action => :edit
    end
  end


  private
  
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:perishable_token])
    unless @user
      flash[:notice] = I18n.t("user.flash.edit_password_resets_not_found")
      redirect_to root_url
    end
  end


end
