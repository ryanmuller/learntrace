class AddPincountToItems < ActiveRecord::Migration
  def change
    add_column :items, :pins_count, :integer, :default => 0

    Item.reset_column_information

    Item.all.each do |item|
      Item.update_counters(item.id, :pins_count => item.pins.length)
    end
  end
end
