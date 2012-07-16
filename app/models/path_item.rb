class PathItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :path
end
