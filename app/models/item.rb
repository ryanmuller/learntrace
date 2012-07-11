class Item < ActiveRecord::Base
  has_many :pins
  has_many :users, :through => :pins
  has_many :taggings
  has_many :tags, :uniq => true, :through => :taggings do
    def push_with_attributes(tag, join_attrs)
      Tagging.with_scope(:create => join_attrs) { self << tag }
    end
  end

  scope :featured, order('pins_count DESC').limit(4)
end
