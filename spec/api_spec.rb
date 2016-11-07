require_relative 'spec_helper.rb'
require 'yaml'

describe 'API basics' do

 # test 01
  it 'should find configuration information' do
    app.config.DATA_ID.length.must_be :>, 0
   
  end

  # test 02
  it 'should successfully find the root route' do
    get '/'    
    #200 OK Standard response for successful HTTP requests.
    last_response.status.must_equal 200
    

  end

end
