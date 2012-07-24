class AddForksCount < ActiveRecord::Migration
  def up
    add_column :streams, :forks_count, :integer, :default => 0
    Stream.reset_column_information
    Stream.find_each do |s|
      Stream.reset_counters s.id, :forks
    end
  end

  def down
    remove_column :streams, :forks_count
  end
end
