class Path < ActiveRecord::Base
  belongs_to :user
  has_many :path_items
  has_many :items, :through => :path_items
end
