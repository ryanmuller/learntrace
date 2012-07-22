class AddCompletedAtToPins < ActiveRecord::Migration
  def change
    add_column :pins, :completed_at, :datetime

  end
end
