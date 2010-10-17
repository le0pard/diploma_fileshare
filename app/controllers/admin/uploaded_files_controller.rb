class Admin::UploadedFilesController < Admin::BaseController
  
  cache_sweeper :upload_file_sweeper, :only => [:create, :update, :destroy]
  
  def index
    @uploaded_files = UploadedFile.admin.paginate :page => (params[:page] || 1), :per_page => 100
  end
  
  def new
    @uploaded_file = UploadedFile.new
  end
  
  def create
    @uploaded_file = UploadedFile.new(params[:uploaded_file])
    @uploaded_file.user = current_user
    if @uploaded_file.save
      flash[:notice] = I18n.t("admin.uploaded_file.flash.add_notice")
      redirect_to :action => :edit, :id => @uploaded_file.id
    else
      render :action => :new
    end
  end
  
  def edit
    @uploaded_file = UploadedFile.find(params[:id])
  end
  
  def update
    @uploaded_file = UploadedFile.find(params[:id])
    if @uploaded_file.update_attributes(params[:uploaded_file])
      flash[:notice] = I18n.t("admin.uploaded_file.flash.update_notice")
      redirect_to :action => :edit, :id => @uploaded_file.id
    else
      render :action => :edit
    end
  end
  
  def destroy
    @uploaded_file = UploadedFile.find(params[:id])
    @uploaded_file.destroy
    flash[:notice] = I18n.t("admin.uploaded_file.flash.delete_notice")
    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to :action => :index
    end
  end
  
  def bulk
    if params[:actions] && params[:action]
      case params[:actions].to_i
        when 1 
          params[:bulk_action].each do |action_id|
            uploaded_file = UploadedFile.find(action_id)
            uploaded_file.destroy
          end
          flash[:notice] = I18n.t("admin.uploaded_file.flash.delete_notice")
        else
          #else
      end      
    end
    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to :action => :index
    end
  end
  
end
