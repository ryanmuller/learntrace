class AddFeaturedToStream < ActiveRecord::Migration
  def change
    add_column :streams, :featured, :boolean, null: false, default: false
  end
end
