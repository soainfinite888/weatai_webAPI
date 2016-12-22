# frozen_string_literal: true
require 'econfig'
require 'shoryuken'

# folders = 'lib,values,config,models,representers,services'
# Dir.glob("../{#{folders}}/init.rb").each do |file|
#   require file
# end

require_relative '../lib/init.rb'
require_relative '../values/init.rb'
require_relative '../config/init.rb'
require_relative '../models/init.rb'
require_relative '../representers/init.rb'
require_relative '../services/init.rb'

class CreateNewUserWeatherWorker
  extend Econfig::Shortcut
  Econfig.env = ENV['RACK_ENV'] || 'development'
  Econfig.root = File.expand_path('..', File.dirname(__FILE__))

  Shoryuken.configure_client do |shoryuken_config|
    shoryuken_config.aws = {
      access_key_id:      CreateNewUserWeatherWorker.config.AWS_ACCESS_KEY_ID,
      secret_access_key:  CreateNewUserWeatherWorker.config.AWS_SECRET_ACCESS_KEY,
      region:             CreateNewUserWeatherWorker.config.AWS_REGION
    }
  end

  FaceGroup::FbApi.config.update(
    client_id:      CreateNewUserWeatherWorker.config.FB_CLIENT_ID,
    client_secret:  CreateNewUserWeatherWorker.config.FB_CLIENT_SECRET
  )

CWB::CWBApi.config.update(dataid1: config.DATA_ID1,
                          dataid2: config.DATA_ID2,
                          key:     config.AUTH_KEY, 
                          format:  config.FORMAT,
                          token:   config.TOKEN)
end
  include Shoryuken::Worker
  shoryuken_options queue: config.GROUP_QUEUE, auto_delete: true

  def perform(_sqs_msg, fb_id)
    puts "REQUEST: #{fb_id}"
    result = CreateNewGroup.call(fb_id)
    puts "RESULT: #{result.value}"

    HttpResultRepresenter.new(result.value).to_status_response
  end
end
