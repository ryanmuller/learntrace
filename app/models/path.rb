class Path < ActiveRecord::Base
  belongs_to :user
  has_many :pins
  has_many :items, :through => :pins

  validates :name, :presence => true
end
