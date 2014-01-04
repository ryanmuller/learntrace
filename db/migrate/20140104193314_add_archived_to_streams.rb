class AddArchivedToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :archived, :boolean, null: false, default: false
  end
end
