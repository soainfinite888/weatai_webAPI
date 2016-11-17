# frozen_string_literal: true

# configure based on environment

# WeataiAPI web service

class WeataiAPI < Sinatra::Base
  #extend Econfig::Shortcut

  API_VER = 'api/v0.1'

  get '/?' do
    "WeataiAPI latest version endpoints are at: /#{API_VER}/"
  end
end
