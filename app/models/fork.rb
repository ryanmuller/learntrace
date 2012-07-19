class Fork < ActiveRecord::Base
  attr_accessible :source_id, :target_id

  belongs_to :source, class_name: "Stream"
  belongs_to :target, class_name: "Stream"

  validates :source_id, presence: true
  validates :target_id, presence: true

  after_create :copy_pins

  private
  def copy_pins
    user = target.user

    delta = nil
    source.pins.order('scheduled_at').each do |pin|
      new_pin = user.pin!(pin.item, target)

      if pin.scheduled_at
        if delta.nil?
          delta = Time.now - pin.scheduled_at
        end

        new_pin.scheduled_at = pin.scheduled_at + delta
        new_pin.save
      end
    end
  end

end
