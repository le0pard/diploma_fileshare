class CreateUploadedFiles < ActiveRecord::Migration
  def self.up
    create_table :uploaded_files do |t|
      t.integer   :user_id, :null => false
      t.integer   :catalog_id, :null => true, :default => nil
      t.string    :title, :null => false
      t.text      :description
      t.string    :attachment_file_name
      t.string    :attachment_content_type
      t.integer   :attachment_file_size
      t.datetime  :attachment_updated_at
      t.string    :meta_title
      t.string    :meta_description
      t.boolean   :is_public, :default => true
      t.boolean   :is_autorization, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :uploaded_files
  end
end
