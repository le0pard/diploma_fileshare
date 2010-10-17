class UploadFileSweeper < ActionController::Caching::Sweeper
  observe UploadedFile
  
  def clear_cache(obj)
    expire_fragment "image_top_list"
    expire_fragment "image_#{obj.id}"
  end
  
  def after_save(obj)
    clear_cache obj
  end

  def after_destroy(obj)
    clear_cache obj
  end
end
