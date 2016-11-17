#Configure blocks allow we to run code specific to RACK_ENV environment variable for Sinatra
require 'sinatra' 
require 'sequel'


#Configurations only for development
#Put dev database URL in environment variable
configure :development do 
  ENV['DATABASE_URL'] = 'sqlite://db/dev.db'
end


#Configurations only for testing
#Put test database URL in environment variable
configure :test do
  ENV['DATABASE_URL'] = 'sqlite://db/test.db'
end




#Hirb 
configure :development, :production do 
  require 'hirb'
  Hirb.enable
end


#Configurations for all environments
#Enable logging in Sinatra
#Connect to database
configure do
  DB = Sequel.connect(ENV['DATABASE_URL'])
end