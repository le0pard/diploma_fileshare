class Catalog < ActiveRecord::Base

  # === List of columns ===
  #   id                : integer 
  #   parent_id         : integer 
  #   lft               : integer 
  #   rgt               : integer 
  #   depth             : integer 
  #   title             : string 
  #   slug              : string 
  #   description       : text 
  #   meta_title        : string 
  #   meta_description  : string 
  #   is_active         : boolean 
  #   is_visible        : boolean 
  #   icon_file_name    : string 
  #   icon_content_type : string 
  #   icon_file_size    : integer 
  #   icon_updated_at   : datetime 
  #   created_at        : datetime 
  #   updated_at        : datetime 
  # =======================

  
  acts_as_nested_set
  
  before_save :set_slug
  
  validates :title, :presence => true, :uniqueness => true
  validates :meta_title, :presence => true
  validates :meta_description, :length => { :minimum => 0, :maximum => 255 }
  
  has_attached_file :icon, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  
  
  def self.tree
    catalogs = self.roots.all
  end
  
  def self.subtree(catalog_id)
    catalog = self.find(catalog_id)
    catalog.nil? ? [] : catalog.children
  end
  
  
  private
  
  def set_slug
    return nil if self.title.nil?
    value = Russian.translit(self.title)
    value = value.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    value = value.gsub(/[']+/, '').gsub(/\W+/, ' ').strip.downcase.gsub(' ', '-')
    self.slug = value
  end
  
end
