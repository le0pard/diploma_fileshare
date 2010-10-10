class UploadedFile < ActiveRecord::Base

  # === List of columns ===
  #   id                      : integer 
  #   user_id                 : integer 
  #   catalog_id              : integer 
  #   title                   : string 
  #   description             : text 
  #   attachment_file_name    : string 
  #   attachment_content_type : string 
  #   attachment_file_size    : integer 
  #   attachment_updated_at   : datetime 
  #   meta_title              : string 
  #   meta_description        : string 
  #   is_public               : boolean 
  #   is_autorization         : boolean 
  #   created_at              : datetime 
  #   updated_at              : datetime 
  # =======================

  
  belongs_to :user
  belongs_to :catalog
  
  validates :title, :presence => true
  
  has_attached_file :attachment, 
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" }
  
  define_index do
    # fields
    indexes title, :sortable => true
    indexes description
    indexes user.email, :as => :user, :sortable => true
    indexes catalog.title, :as => :catalog, :sortable => true
    
    # attributes
    has user_id, catalog_id, created_at, updated_at, attachment_updated_at
    
    where "is_public = 1"
  end
                                
end
