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
=begin
  get "/#{API_VER}/group/:fb_group_id/feed/?" do
    group_id = params[:fb_group_id]
    begin
      group = FaceGroup::Group.find(id: group_id)

      content_type 'application/json'
      {
        feed: group.feed.postings.map do |post|
          posting = { posting_id: post.id }
          posting[:message] = post.message if post.message
          if post.attachment
            posting[:attachment] = {
              title: post.attachment.title,
              url: post.attachment.url,
              description: post.attachment.description
            }
          end

          { posting: posting }
        end
      }.to_json
    rescue
      halt 404, "Cannot group (id: #{group_id}) feed"
    end
  end
=end
end
