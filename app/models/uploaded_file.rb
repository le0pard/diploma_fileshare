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
  #   slug                    : string 
  #   diff_array              : string 
  # =======================

  
  belongs_to :user
  belongs_to :catalog
  
  before_save :set_slug
  
  validates :title, :presence => true
  validates :description, :presence => true
  validates_attachment_presence :attachment, :message => I18n.t("admin.uploaded_file.errors.validates_attachment_presence")
  validates_attachment_content_type :attachment, 
    :content_type=>['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/jpg'], 
    :message => I18n.t("admin.uploaded_file.errors.validates_attachment_content_type")
  validates_attachment_size :attachment, :less_than => 15.megabyte, :message => I18n.t("admin.uploaded_file.errors.validates_attachment_size")
  
  has_attached_file :attachment, 
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>",
                                 :large => "800x800>" }
  
  after_attachment_post_process :set_diff_array
  
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
  
  scope :account, lambda { 
    order("uploaded_files.attachment_updated_at DESC")
  }
  scope :published, lambda { 
    where({:is_public => true}).order("uploaded_files.attachment_updated_at DESC")
  }
  scope :by_catalog, lambda { |catalog|
    where({:catalog_id => catalog.id})
  }
  scope :admin, order("uploaded_files.attachment_updated_at DESC")

  
  def is_public_text
    self.is_public ? I18n.t("admin.uploaded_file.attributes.is_public_yes") : I18n.t("admin.uploaded_file.attributes.is_public_no")
  end
  
  def is_autorization_text
    self.is_autorization ? I18n.t("admin.uploaded_file.attributes.is_autorization_yes") : I18n.t("admin.uploaded_file.attributes.is_autorization_no")
  end
  
  def get_simillar(percent, own_limit = 10)
    own_where = "round((icount(uploaded_files.diff_array::int[] & '#{self.diff_array}'::int[])::numeric / ((icount(uploaded_files.diff_array::int[]) + icount('#{self.diff_array}'::int[])) / 2)::numeric) * 100, 2)"
    UploadedFile.select("uploaded_files.*, #{own_where} AS simillar_percentes").
      where(["#{own_where} >= ? AND id != ?", percent, self.id]).order(own_where + " DESC").limit(own_limit)
  end
  
  protected
  
  def set_slug
    return nil if self.title.nil?
    value = Russian.translit(self.title)
    value = value.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    value = value.gsub(/[']+/, '').gsub(/\W+/, ' ').strip.downcase.gsub(' ', '-')
    self.slug = value
  end
  
  def set_diff_array
    if self.attachment.queued_for_write[:original].path
      img_diff = ImageDiff.new
      main_array = img_diff.generate_array(self.attachment.queued_for_write[:original].path)
      self.diff_array = "{#{main_array.join(",")}}"
    end
  end

                            
end
