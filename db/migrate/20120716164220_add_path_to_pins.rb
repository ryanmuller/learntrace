class AddPathToPins < ActiveRecord::Migration
  def change
    change_table :pins do |t|
      t.references :path
    end
  end
end
