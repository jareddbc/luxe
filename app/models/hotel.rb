require 'bcrypt'

class Hotel < ActiveRecord::Base
  has_secure_password

  has_many :guests,   dependent: :destroy
  has_many :menus,    dependent: :destroy
  has_many :services, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :address
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_length_of :password, minimum: 6
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  after_create :create_calendar!

  def self.authenticate(email, password)
    hotel = find_by_email(email)
    if hotel && hotel.password_hash == BCrypt::Engine.hash_secret(password, hotel.password_salt)
      hotel
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def calendar
    Calendar.new(calendar_id) if calendar_id.present?
  end

  def calendar=(calendar)
    self.calendar_id = calendar ? calendar.id : nil
  end

  private

  def create_calendar!
    update calendar: Calendar.create(self.name)
  end

end
