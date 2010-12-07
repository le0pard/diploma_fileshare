class AddDiffArrayIndexToUploadFile < ActiveRecord::Migration
  def self.up
    add_index :uploaded_files, :diff_array
  end

  def self.down
    remove_index :uploaded_files, :diff_array
  end
end
