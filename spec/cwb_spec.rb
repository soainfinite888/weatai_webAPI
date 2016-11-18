require_relative 'spec_helper.rb'
require 'yaml'

describe 'CWB routes' do
  before do
    VCR.insert_cassette 'all_record', record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

SAD_DATA_ID = '00000'
API_VER = 'api/v0.1'

 # test 01

  it 'get latest version' do
    get '/'
    last_response.status.must_equal 200
  end 

  it 'HAPPY: should get data' do
    get "#{API_VER}/C_weather"
    last_response.status.must_equal 200
    last_response.content_type.must_equal 'application/json'
  end
  
  it 'SAD: should not found data' do
    get "#{API_VER}/C_weather/#{SAD_DATA_ID}"
    last_response.status.must_equal 404
  end

  it 'should load data into database' do
    DB[:C_weather].delete
    put '/#{API_VER}/C_weather/基隆',
        {instant_weather: weather}.to_json,
        'content_type' => 'application/json'
    last_response.status.must_equal 200
    C_weather.count.must_equal 1
     

  end
end
