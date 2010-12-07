class UploadFileSweeper < ActionController::Caching::Sweeper
  observe UploadedFile
  
  def clear_cache(obj)
    expire_fragment "image_top_list"
    expire_fragment "image_#{obj.id}"
    similar_files = obj.get_simillar(60)
    unless similar_files.blank?
      similar_files.each do |upl_file|
        expire_fragment "image_#{upl_file.id}"
      end
    end
  end
  
  def after_save(obj)
    clear_cache obj
  end

  def after_destroy(obj)
    clear_cache obj
  end
end
