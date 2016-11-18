ENV['RACK_ENV'] = 'test'  #Declare we are in test environment  

#require 'simplecov'
#SimpleCov.start

#require for testing
require 'minitest/autorun'
require 'minitest/rg'
require 'rack/test'
require 'vcr'
require 'webmock'

#require(others)

require 'http'
require 'yaml'
require 'active_support/all'
require 'active_support/core_ext/hash'
require 'rubygems'
require 'sinatra'



#load web app. for testing
require_relative '../app' 

#load useful web app. test methods
include Rack::Test::Methods

#give WeataiAPI a nickname: app
def app
	WeataiAPI
end

FIXTURES_FOLDER = 'spec/fixtures'
CASSETTES_FOLDER = #{FIXTURES_FOLDER}/cassettes
GROUPS_CASSETTE = 'groups' 

#VCR things 
VCR.configure do |c|
  c.cassette_library_dir = 'cassettes'
  c.hook_into :webmock

end
