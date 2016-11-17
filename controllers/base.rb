# frozen_string_literal: true

# configure based on environment

# WeataiAPI web service

class WeataiAPI < Sinatra::Base
  #extend Econfig::Shortcut

  API_VER = 'api/v0.1'

  configure do
    #Econfig.env = settings.environment.to_s
    #Econfig.root = settings.root
    #CWB::INSTANT

    #                         key:  config.AUTH_KEY)
    
    #改這裡改這裡
    #weather = CWB::INSTANT.instant
    #CWB::INSTANT.config.update(dataid: config.DATA_ID,
    #                          key:  config.AUTH_KEY)


  end

  get '/?' do
    "WeataiAPI latest version endpoints are at: /#{API_VER}/"
  end
end
