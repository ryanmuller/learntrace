class AddThumbUrlToItem < ActiveRecord::Migration
  def change
    add_column :items, :thumb_url, :string

  end
end
