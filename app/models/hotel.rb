require 'bcrypt'

class Hotel < ActiveRecord::Base
  has_secure_password

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :address
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_length_of :password, minimum: 6
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create



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

end
