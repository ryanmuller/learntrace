class AddScheduleToPins < ActiveRecord::Migration
  def change
    add_column :pins, :scheduled_at, :datetime

  end
end
