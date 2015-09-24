class Guest < ActiveRecord::Base
  belongs_to :hotel
  has_many :services, dependent: :destroy
end
