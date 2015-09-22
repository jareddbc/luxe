class Item < ActiveRecord::Base
  has_many :services, :through => :menus
end
