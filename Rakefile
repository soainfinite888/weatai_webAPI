require 'rake/testtask'

#Rake::TestTask is object creates a test task that can run multiple testing files.
Rake::TestTask.new(:spec) do |t|
  t.pattern ='spec/*_spec.rb'
  t.warning = false

end


desc 'run tests' 
task :spec do 
  sh 'ruby spec/weatai_spec.rb' 
end

namespace :quality do 
  desc 'run all quality checks' 
  task all: [:rubocop, :flog, :flay]

  desc 'run quality:flog in lib'
  task :flog do 
    sh 'flog lib/' 
  end

  desc 'run quality:flay in lib'
  task :flay do 
    sh 'flay lib/' 
  end

  desc 'run quality:rubocop in lib'
  task :rubocop do 
    sh 'rubocop lib/' 
  end 
end
