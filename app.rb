require 'sinatra'
require 'slim'

#--------------------App_Routes--------------------#

get '/' do
  slim :index
end
