class Stream < ActiveRecord::Base
  belongs_to :user
  has_many :pins
  has_many :items, :through => :pins
  has_many :forks, foreign_key: "source_id"
  has_many :targets, through: :forks
  has_many :back_forks, class_name: "Fork", foreign_key: "target_id"
  has_many :sources, through: :back_forks, source: :source

  validates :name, :presence => true

  scope :popular, joins('LEFT OUTER JOIN forks ON forks.source_id = streams.id').order('forks.created_at ASC') 
                                                                                                              # note... doesn't select unique! Having trouble getting
                                                                                                              # .uniq to work with postgres... 
                                                                                                               

  def upstream?(source)
    back_forks.find_by_source_id(source.id)
  end

  def fork!(source)
    back_forks.create!(source_id: source.id, target_id: id)
  end

  def dam!(source)
    back_forks.find_by_source_id(source.id).destroy
  end
end
