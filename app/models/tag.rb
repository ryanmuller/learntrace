class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :items, :through => :taggings
  has_many :users, :through => :taggings

  validates :name, :presence => true
  validates :name, :uniqueness => true


  def tagging_by_user?(user, item)
    Tagging.where(:user_id => user.id, :tag_id => self.id, :item_id => item.id).count > 0
  end

  def tagging_by_user_item(user, item)
    Tagging.where(:user_id => user.id, :tag_id => self.id, :item_id => item.id).first
  end

  
end
