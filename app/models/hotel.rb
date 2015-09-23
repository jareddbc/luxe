require 'bcrypt'

class Hotel < ActiveRecord::Base
  has_secure_password
  # attr_reader :password_confirmation

  # attr_accessor :password, :email
  # before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

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

end
