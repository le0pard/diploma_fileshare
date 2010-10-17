class UploadFileSweeper < ActionController::Caching::Sweeper
  observe UploadedFile
  
  def clear_cache(obj)
    expire_page image_link_path(:id => obj.id, :slug => obj.slug)
    expire_fragment "image_top_list"
  end
  
  def after_save(obj)
    clear_cache obj
  end

  def after_destroy(obj)
    clear_cache obj
  end
end
