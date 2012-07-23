class Item < ActiveRecord::Base
  has_many :pins
  has_many :users, :through => :pins
  has_many :streams, :through => :pins

  has_many :taggings, :dependent => :destroy
  has_many :tags, :uniq => true, :through => :taggings do
    def push_with_attributes(tag, join_attrs)
      Tagging.with_scope(:create => join_attrs) { self << tag }
    end
  end
  has_many :comments

  before_create :add_thumb

  scope :featured, order('pins_count DESC').limit(4)
  scope :best, order('pins_count DESC')

  def tags_by_user(user)
   Tag.joins(:taggings => :user).where('taggings.user_id' => user.id, 'taggings.item_id' => self.id)
  end

  def pinned_by_user?(user)
    users.include?(user)
  end

  def user_pin(user)
    pins.where('pins.user_id = ?', user.id).first
  end

  def thumb_url
    read_attribute(:thumb_url) || write_attribute(:thumb_url, "/assets/no-thumbnail.png")
  end

  private
  def add_thumb
    unless self.thumb_url
      begin 
        require 'open-uri'
        require 'json'

        api_call = "http://api.embed.ly/1/oembed?key=309c8f118a624159a31ec483f7ae5ceb&url=#{URI.escape(self.url)}"

        resp = JSON.parse(open(api_call).read)
        if resp['thumbnail_url']
          self.thumb_url = resp['thumbnail_url']
        else
          require 'scraper_utils'
          self.thumb_url = ScraperUtils.find_thumb(self.url)
        end
      rescue
        puts "no thumb available: #{self.url}"
      end
    end
  end
end
