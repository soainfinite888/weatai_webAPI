require_relative 'spec_helper.rb'
require 'yaml'

describe 'CWB routes' do

#......................VCR things........................

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

#......................VCR things........................

  describe '' do

 # test 01
  it 'HAPPY: should get data' do 
     #http 200 OK
      last_response.status.must_equal 200
      #last_response.content_type.must_equal 'application/yaml'
      #group_data['group_id'].length.must_be :>, 0
      #group_data['name'].length.must_be :>, 0
    end
  
  it 'SAD: should not found data' do
      #http 404 not find
      last_response.status.must_equal 404
      #last_response.body.must_include [fix]
    end

  end
end
