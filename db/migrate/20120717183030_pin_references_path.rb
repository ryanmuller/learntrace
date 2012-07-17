class PinReferencesPath < ActiveRecord::Migration
  def up
    rename_column :pins, :path_id, :stream_id

    add_index "pins", ["stream_id"], :name => "index_pins_on_stream_id"
  end

  def down
    rename_column :pins, :stream_id, :path_id

    remove_index :pins, :name => "index_pins_on_stream_id"
  end
end
