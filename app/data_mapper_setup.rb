require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './app/models/link' # require each model individually - the path may vary depending on your file structure.
require './app/models/tag'
require './app/models/user'
require 'dm-validations'
# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!
#If we call auto_migrate, it will create a brand new database, even if we're making a small change it will clear all of the data from the database and reinitialize the database
#in it's initial state.
#Auto-upgrade will try and make any changes to our model.
