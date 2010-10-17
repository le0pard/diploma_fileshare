class Site::FilesController < Site::BaseController
  
  def index
    @uploaded_file = UploadedFile.new
    @uploaded_files = UploadedFile.published.limit("30").all
  end
  
  def create
    @uploaded_file = UploadedFile.new(params[:uploaded_file])
    @uploaded_file.user = current_user
    if @uploaded_file.save
      flash[:notice] = I18n.t("flash.upload_notice")
      redirect_to image_link_path(:id => @uploaded_file.id, :slug => @uploaded_file.slug)
    else
      render :action => :index
    end
  end
  
  def show
    @uploaded_file = UploadedFile.find_by_id_and_slug(params[:id], params[:slug])
    redirect_to root_path if @uploaded_file.nil?
  end
  
  def search
    
  end
  
end
