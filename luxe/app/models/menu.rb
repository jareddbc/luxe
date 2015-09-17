class Menu < ActiveRecord::Base
	belongs_to :item
	belongs_to :service
end
