class CreatePathItems < ActiveRecord::Migration
  def change
    create_table :path_items do |t|
      t.references :item
      t.references :path

      t.timestamps
    end
    add_index :path_items, :item_id
    add_index :path_items, :path_id
  end
end
