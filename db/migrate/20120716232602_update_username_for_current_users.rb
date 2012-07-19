class UpdateUsernameForCurrentUsers < ActiveRecord::Migration
  def up
    User.find(:all).each do |u|
      u.username = (u.name.nil? || u.name.blank?) ? u.id.to_s : u.name.sub(/[^a-zA-Z_\-\.]/, ".").downcase
      u.save!
    end
  end

  def down
    User.find(:all).each do |u|
      u.username = nil
    end
  end
end
