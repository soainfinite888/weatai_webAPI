source 'https://rubygems.org'

gem 'sinatra', '2.0.0.beta2'
gem 'puma'
gem 'econfig'
gem 'http'
gem 'activesupport'
gem 'simplecov'
gem 'flog'
gem 'flay'
gem 'rubocop'
gem 'weatai'
gem 'json'
gem 'sequel'


group :development, :test do
	gem 'sqlite3'
end

group :development do
  gem 'rerun'

  gem 'flog'
  gem 'flay'
end

#needed for our test deployment environment
group :test do 
  gem 'minitest' 
  gem 'minitest-rg' 

  gem 'rack-test' #testing methods for web app.
  gem 'rake'

  gem 'vcr'
  gem 'webmock'

end

group :development, :production do
  gem 'tux'
  gem 'hirb'
end

group :production do
  gem 'pg'
end





