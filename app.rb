require 'sinatra'
require 'econfig'
require 'weatai'

# WeataiAPI web service
class WeataiAPI < Sinatra::Base
  extend Econfig::Shortcut

  Econfig.env = settings.environment.to_s
  Econfig.root = settings.root
  CWB::CWBApi
    .config
    .update(dataid: config.DATA_ID,
            key:  config.AUTH_KEY)

  API_VER = 'api/v0.1'

  get '/?' do
    "WeataiAPI latest version endpoints are at: /#{API_VER}/"
  end

  get "/#{API_VER}/C_weather/?" do
    begin
      weather = CWB::Weather.find(dataid: 'O-A0003-001')
      content_type 'application/json'
      { instant_weather: weather.instant_weather }.to_json
    rescue
      halt 404, "Instant weather not found"
    end
  end
end
