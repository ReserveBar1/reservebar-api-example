require 'rack-livereload'
use Rack::LiveReload, :source => :vendored

require './app'
run Sinatra::Application
