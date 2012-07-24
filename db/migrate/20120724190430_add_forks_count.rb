class AddForksCount < ActiveRecord::Migration
  def up
    add_column :streams, :forks_count, :integer, :default => 0
    Stream.reset_column_information
    Stream.all.each do |s|
      s.update_attribute :forks_count, s.forks.length
    end
  end

  def down
    remove_column :streams, :forks_count
  end
end
