class Pin < ActiveRecord::Base
  attr_accessible :item_id, :status, :stream_id, :scheduled_at, :completed_at

  belongs_to :user
  belongs_to :item, :counter_cache => true
  belongs_to :stream

  validates :user_id, presence: true
  validates :item_id, presence: true

  scope :todo, where("completed_at IS NULL")
  scope :done, where("completed_at IS NOT NULL")

  scope :before_today, where("scheduled_at < ?", Date.today.beginning_of_day)
  scope :today, where("scheduled_at between ? and ?", Date.today.beginning_of_day, Date.tomorrow.beginning_of_day)
  scope :overdue, todo.before_today
  scope :due_today, todo.today
  scope :done_today, done.today

  scope :timeline, where("scheduled_at IS NOT NULL").order('scheduled_at')

  default_scope order('completed_at, scheduled_at')

  def stream_name
    stream.nil? ? "Library" : stream.name
  end


  def copy_to_forks
    stream.targets.each do |target|
      user = target.user
      user.pin!(item, target)
    end
  end

  def display_date
    completed_at || scheduled_at || Time.now + 1.day # ugh, still have some pins with no completed/scheduled_at...
  end

  def complete!
    update_attributes!({ completed_at: Time.now })
  end

  def complete?
    not completed_at.nil?
  end
end
