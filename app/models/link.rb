class Link

  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :url, String

  has n, :tags, through: Resource #this creates an association between link and tag classes/tables.
  #has is the method, n is the parameter. N means 'any number'. So here we're saying Link has as many tags as it wants
  
end
