class CreateForks < ActiveRecord::Migration
  def change
    create_table :forks do |t|
      t.references :source
      t.references :target

      t.timestamps
    end
    add_index :forks, :source_id
    add_index :forks, :target_id
    add_index :forks, [:source_id, :target_id], unique: true
  end
end
