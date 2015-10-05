require "bcrypt"

class Company < ActiveRecord::Base
has_many :jobs
  
  def password=(new_password)
    @password = new_password
    self.encrypted_password = BCrypt::Password.create(@password)
  end

  def password
    @password
  end

  def valid_password?(password_to_validate)
  BCrypt::Password.new(encrypted_password) == password_to_validate
  end

validates_presence_of :email, :name, :password
validates_uniqueness_of :email
validates_length_of :password, minimum: 6
validates_confirmation_of :password
end

