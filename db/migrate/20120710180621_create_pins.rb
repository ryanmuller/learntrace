class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.references :user
      t.references :item

      t.timestamps
    end
    add_index :pins, :user_id
    add_index :pins, :item_id
  end
end
