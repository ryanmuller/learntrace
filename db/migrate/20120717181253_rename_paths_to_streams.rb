class RenamePathsToStreams < ActiveRecord::Migration
  def up
    rename_table :paths, :streams
  end

  def down
    rename_table :stream, :paths
  end
end
