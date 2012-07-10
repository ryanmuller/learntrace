class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :user
      t.references :tag
      t.references :item

      t.timestamps
    end
    add_index :taggings, :user_id
    add_index :taggings, :tag_id
    add_index :taggings, :item_id
  end
end
