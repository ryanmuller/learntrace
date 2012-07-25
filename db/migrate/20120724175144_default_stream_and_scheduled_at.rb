class DefaultStreamAndScheduledAt < ActiveRecord::Migration
  def up
    Pin.all.each do |pin|
      unless pin.stream
        item = pin.item
        user = pin.user
        stream = user.streams.find_by_name("Unsorted items") || Stream.create!(user: user, name: "Unsorted items")
        user.unpin!(item)
        pin = user.pin!(item, stream)
      end

      pin.save # applies default_scheduled_at
    end
  end
end
