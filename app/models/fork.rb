class Fork < ActiveRecord::Base
  attr_accessible :source_id, :target_id

  belongs_to :source, class_name: "Stream"
  belongs_to :target, class_name: "Stream"

  validates :source_id, presence: true
  validates :target_id, presence: true
end
