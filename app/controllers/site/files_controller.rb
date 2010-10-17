class Site::FilesController < Site::BaseController
  
  before_filter :require_user, :only => [:create]
  caches_page :show
  cache_sweeper :upload_file_sweeper, :only => [:create]
  
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
    if params[:s]
      @uploaded_files = UploadedFile.search params[:s], :order => :attachment_updated_at, 
        :sort_mode => :desc, :page => (params[:page] || 1), :per_page => 60
    else
      redirect_to root_path
    end
  end
  
  def catalog
    @catalog = Catalog.find_by_id_and_slug(params[:id], params[:slug])
    redirect_to root_path if @catalog.nil?
    @catalog_tree = @catalog.children
    @uploaded_files = UploadedFile.published.by_catalog(@catalog).paginate :page => (params[:page] || 1), :per_page => 60
  end
  
end
