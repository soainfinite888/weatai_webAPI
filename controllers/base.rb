# frozen_string_literal: true
require 'sinatra'
require 'econfig'

# configure based on environment
class WeataiAPI < Sinatra::Base
  extend Econfig::Shortcut

  Shoryuken.configure_server do |config|
    config.aws = {
      access_key_id:      config.AWS_ACCESS_KEY_ID,
      secret_access_key:  config.AWS_SECRET_ACCESS_KEY,
      region:             config.AWS_REGION
    }
  end

  API_VER = 'api/v0.1'

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..',settings.root)
    CWB::CWBApi.config.update(dataid1: config.DATA_ID1,
                              dataid2: config.DATA_ID2,
                              key:     config.AUTH_KEY, 
                              format:  config.FORMAT,
                              token:   config.TOKEN)
  end

  get '/?' do
    {
      status: 'OK',
      message: "WeataiAPI latest version endpoints are at: /#{API_VER}/"
    }.to_json
  end
end
