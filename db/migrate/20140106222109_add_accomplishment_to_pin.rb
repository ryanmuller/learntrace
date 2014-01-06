class AddAccomplishmentToPin < ActiveRecord::Migration
  def change
    add_column :pins, :summary, :text
    add_column :pins, :pin_media, :string
  end
end
