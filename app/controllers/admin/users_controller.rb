class Admin::UsersController < Admin::BaseController
  
  def index
    @users = User.admin.paginate :page => (params[:page] || 1), :per_page => 30
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = I18n.t("admin.user.flash.add_notice")
      redirect_to :action => :edit, :id => @user.id
    else
      render :action => :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = I18n.t("admin.user.flash.update_notice")
      redirect_to :action => :edit, :id => @user.id
    else
      render :action => :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = I18n.t("admin.user.flash.delete_notice")
    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to :action => :index
    end
  end
  
end
