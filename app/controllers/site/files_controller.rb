class Site::FilesController < Site::BaseController
  
  before_filter :require_user, :only => [:new, :create]
  cache_sweeper :upload_file_sweeper, :only => [:create, :update]
  
  def index
    @uploaded_files = UploadedFile.published.limit("30").all
  end
  
  def new
    @uploaded_file = UploadedFile.new
  end
  
  def create
    @uploaded_file = UploadedFile.new(params[:uploaded_file])
    @uploaded_file.user = current_user
    if @uploaded_file.save
      flash[:notice] = I18n.t("flash.upload_notice")
      redirect_to image_link_path(:id => @uploaded_file.id, :slug => @uploaded_file.slug)
    else
      render :action => :new
    end
  end
  
  def update
    @uploaded_file = UploadedFile.find_by_id(params[:id])
    if @uploaded_file && current_user && @uploaded_file.user.id == current_user.id
      if params[:update_value]
        @uploaded_file.update_attributes({:description => params[:update_value]})
      end
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :text => text_helper.simple_format(@uploaded_file.description) }
    end
  end
  
  def show
    @uploaded_file = UploadedFile.find_by_id_and_slug(params[:id], params[:slug])
    redirect_to root_path if @uploaded_file.nil?
    @similar_files = @uploaded_file.get_simillar(60)
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
    @catalog_tree_child = true
    @uploaded_files = UploadedFile.published.by_catalog(@catalog).paginate :page => (params[:page] || 1), :per_page => 60
  end
  
  private
  
  def text_helper
    Helper.instance
  end
  
end

class Helper
    include Singleton
    include ActionView::Helpers
end
