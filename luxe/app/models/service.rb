class Service < ActiveRecord::Base
	has_many :items, :through => :menus
  belongs_to :hotel
  belongs_to :guest
  belongs_to :menu
end
