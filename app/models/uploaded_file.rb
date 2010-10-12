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
  
  scope :published, lambda { 
    where({:is_public => true}).order("uploaded_files.attachment_updated_at")
  }
  scope :admin, order("uploaded_files.attachment_updated_at")

  
  def self.per_page
    100
  end
  
  def is_public_text
    self.is_public ? I18n.t("admin.uploaded_file.attributes.is_public_yes") : I18n.t("admin.uploaded_file.attributes.is_public_no")
  end
  
  def is_autorization_text
    self.is_autorization ? I18n.t("admin.uploaded_file.attributes.is_autorization_yes") : I18n.t("admin.uploaded_file.attributes.is_autorization_no")
  end

                            
end
