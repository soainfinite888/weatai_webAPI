# frozen_string_literal: true
require 'sinatra'
require 'econfig'

# configure based on environment
class WeataiAPI < Sinatra::Base
  extend Econfig::Shortcut

  API_VER = 'api/v0.1'

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..',settings.root)
    CWB::CWBApi.config.update(dataid1: config.DATA_ID1,
                              dataid2: config.DATA_ID2,
                              key:     config.AUTH_KEY, 
                              format:  config.FORMAT,
                              token:   config.TOKEN)  #key update
  end
  
  get '/?' do
    "WeataiAPI latest version endpoints are at: /#{API_VER}/"
  end

end
