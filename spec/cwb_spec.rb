require_relative 'spec_helper.rb'
#require_relative '../app.rb'
require 'yaml'

describe 'CWB routes' do

#......................VCR things........................
=begin 
  VCR.configure do |c|
    c.cassette_library_dir = 'cassettes'
    c.hook_into :webmock

#    c.filter_sensitive_data('<KEY>') { CREDENTIALS[:key] }
  end

  before do
    VCR.insert_cassette 'all_record', record: :new_episodes
#    @cwb_api = CWB::CWBApi.config

  end

  after do
    VCR.eject_cassette
  end
=end

  before do
    VCR.insert_cassette 'all_record', record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

#......................VCR things........................

SAD_DATA_ID = '00000'
API_VER = 'api/v0.1'

 # test 01

  it 'get latest version' do
    get '/'
    #http 200 OK
    last_response.status.must_equal 200
    #puts last_response.body
  end 

  it 'HAPPY: should get data' do
    get "#{API_VER}/C_weather"
    #http 200 OK
    #puts last_response
    last_response.status.must_equal 200
    #data format should be json
    last_response.content_type.must_equal 'application/json'
    
    #_data[''].length.must_be :>, 0
    #_data[''].length.must_be :>, 0
  end
  
  it 'SAD: should not found data' do
    get "#{API_VER}/C_weather/#{SAD_DATA_ID}"
    #http 404 not find
    last_response.status.must_equal 404
    
    #last_response.body.must_include [fix]
  end
end
