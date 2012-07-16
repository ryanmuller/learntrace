class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.references :user
      t.string :name

      t.timestamps
    end
    add_index :paths, :user_id
  end
end
