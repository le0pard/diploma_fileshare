class AddDiffArrayToUploadFile < ActiveRecord::Migration
  def self.up
    #add_column :uploaded_files, :diff_array, :integer
    execute "ALTER TABLE uploaded_files ADD COLUMN diff_array integer[]"
  end

  def self.down
    remove_column :uploaded_files, :diff_array
  end
end
