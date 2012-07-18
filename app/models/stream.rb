class Stream < ActiveRecord::Base
  belongs_to :user
  has_many :pins
  has_many :items, :through => :pins
  has_many :forks, foreign_key: "target_id", dependent: :destroy
  has_many :sources, through: :forks, source: :source

  validates :name, :presence => true

  def upstream?(source)
    forks.find_by_source_id(source.id)
  end

  def fork!(source)
    forks.create!(source_id: source.id, target_id: id)
  end

  def dam!(source)
    forks.find_by_source_id(source.id).destroy
  end
end
