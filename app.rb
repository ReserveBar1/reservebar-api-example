require 'sinatra'
require 'slim'
require 'pry'
require 'httparty'

#--------------------App_Routes--------------------#

get '/' do
  url = "http://localhost:3000/api/products.json"
  @resp = HTTParty.get(url)
  slim :index
end
