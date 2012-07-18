class Stream < ActiveRecord::Base
  belongs_to :user
  has_many :pins
  has_many :items, :through => :pins
  has_many :forks, foreign_key: "target_id", dependent: :destroy
  has_many :sources, through: :forks, source: :source

  validates :name, :presence => true
end
