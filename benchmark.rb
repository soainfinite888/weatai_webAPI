require './init.rb'

require 'benchmark'

require './init.rb'
require 'benchmark'

print '# API, No Concurrency:   '
puts Benchmark.measure {
  1.times {
    weather = FindAllWeathers.call


  }
}.real

print '# API, With Concurrency: '
puts Benchmark.measure {
  1.times {
    weather = FindAllWeathers.call
    #Concurrent::Promise.execute { Location.where(movie_id: movie[:id]).all }
    #Concurrent::Promise.execute { Movlog::Movie.find(t: movie.title) }
    # latest = FaceGroup::Group.latest_postings(id: group.fb_id)
    # [postings, latest]
  }
}.real


	
