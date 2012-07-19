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

  private
  def add_thumb
    unless self.thumb_url
      require 'scraper_utils'
      self.thumb_url = ScraperUtils.find_thumb(self.url)
    end
  end
end
