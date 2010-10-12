class Admin::UploadedFilesController < Admin::BaseController
  
  def index
    @uploaded_files = UploadedFile.admin.paginate :page => (params[:page] || 1)
  end
  
end
