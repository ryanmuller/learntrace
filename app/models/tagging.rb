class Tagging < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag
  belongs_to :item

  validates :tag_id, :uniqueness => { :scope => [:user_id, :item_id] }
end
