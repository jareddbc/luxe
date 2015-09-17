class Service < ActiveRecord::Base
	has_many :items, :through => :menus
end
