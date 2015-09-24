require 'bcrypt'

class User

  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_confirmation_of :password

  property :id, Serial
  property :email, String, required: true #because we're requiring email, the validates_presence_of :email above is unneccesary
  property :password_digest, Text

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end 
  end


end
