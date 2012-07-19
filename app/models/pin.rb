class Pin < ActiveRecord::Base
  attr_accessible :item_id, :status, :stream_id

  belongs_to :user
  belongs_to :item, :counter_cache => true
  belongs_to :stream

  validates :user_id, presence: true
  validates :item_id, presence: true

  scope :todo, where(:status => "todo")
  scope :doing, where(:status => "doing")
  scope :done, where(:status => "done")

  def stream_name
    stream.nil? ? "Library" : stream.name
  end


  def copy_to_forks
    stream.targets.each do |target|
      user = target.user
      user.pin!(item, target)
    end
  end
end
