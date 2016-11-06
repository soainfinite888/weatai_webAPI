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

 # test 01
  it 
  end

  # test 02
  it 
  end

  #test 03
  it
    end
  end
end
