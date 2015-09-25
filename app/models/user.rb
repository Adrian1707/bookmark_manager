require 'bcrypt'

class User

  include DataMapper::Resource #Include takes all the functions or methods that are inside the Resource module and makes them class methods in the User class
  #now we can use the property method that Datamapper makes available to us.

  attr_reader :password
  attr_accessor :password_confirmation
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_confirmation_of :password
  validates_length_of :password, :min=> 6 #This makes sure password is at least 6 characters long

  property :id, Serial #Datamapper shorthand for unique primary key. Serial just means it's an auto-incremeneting integer.
  property :email, String, required: true #because we're requiring email, the validates_presence_of :email above is unneccesary
  property :password_digest, Text


  #Auto-migrate will make a brand new database.

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
