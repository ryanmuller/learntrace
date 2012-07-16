class Item < ActiveRecord::Base
  has_many :pins
  has_many :users, :through => :pins
  has_many :taggings, :dependent => :destroy
  has_many :tags, :uniq => true, :through => :taggings do
    def push_with_attributes(tag, join_attrs)
      Tagging.with_scope(:create => join_attrs) { self << tag }
    end
  end
  has_many :comments
  has_many :path_items
  has_many :paths, :through => :path_items

  scope :featured, order('pins_count DESC').limit(4)
  scope :best, order('pins_count DESC')
end
