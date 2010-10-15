class Admin::UsersController < Admin::BaseController
  
  def index
    @users = User.admin.paginate :page => (params[:page] || 1), :per_page => 30
  end
  
end
