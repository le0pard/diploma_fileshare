class AddIndexForArrayField < ActiveRecord::Migration
  def self.up
    execute "CREATE INDEX uploaded_files_diff_array on uploaded_files using gist (diff_array gist__intbig_ops)"
  end

  def self.down
  end
end
