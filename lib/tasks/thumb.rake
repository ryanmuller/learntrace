require "#{Rails.root}/script/thumb_find.rb"

namespace :thumb do

  desc "Populate thumb_url"
  task :populate => :environment do
    Item.all.each_with_index do |i, index|
      next unless i.thumb_url.nil?
      puts "Finding thumb for #{i.url}... (#{index})"
      i.thumb_url = find_thumb(i.url)
      i.save!
    end
  end
  desc "Populate thumb_url, overwriting current thumb_url"
  task :populate_hard => :environment do
    Item.all.each_with_index do |i, index|
      puts "Finding thumb for #{i.url}... (#{index})"
      i.thumb_url = find_thumb(i.url)
      i.save!
    end
  end
end
