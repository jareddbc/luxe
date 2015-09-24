class Guest < ActiveRecord::Base
  belongs_to :hotel
  has_many :services, dependent: :destroy

   validates_length_of :phone, :is => 10, :message => "Invalid 10 digit phone number"

end
