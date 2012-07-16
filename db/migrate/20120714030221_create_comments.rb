class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :item
      t.text :content

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :item_id
  end
end
