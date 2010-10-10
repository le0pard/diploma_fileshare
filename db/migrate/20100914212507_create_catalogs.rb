class CreateCatalogs < ActiveRecord::Migration
  def self.up
    create_table :catalogs do |t|
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      
      
      t.string :title
      t.string :slug
      t.text :description
      t.string :meta_title
      t.string :meta_description
      t.boolean :is_active, :default => true
      t.boolean :is_visible, :default => false
      
      t.string :icon_file_name
      t.string :icon_content_type
      t.integer :icon_file_size
      t.datetime :icon_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :catalogs
  end
end
