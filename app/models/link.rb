class Link

  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :url, String

  has n, :tags, through: Resource #this creates an association between link and tag classes/tables.

end
