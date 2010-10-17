class AddSlugToUploadedFile < ActiveRecord::Migration
  def self.up
    add_column :uploaded_files, :slug, :string
  end

  def self.down
    remove_column :uploaded_files, :slug
  end
end
