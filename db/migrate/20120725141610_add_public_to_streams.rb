class AddPublicToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :public, :boolean, :default => true
    Stream.find_each do |s|
      s.public = true
    end
  end
end
