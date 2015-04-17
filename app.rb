require 'sinatra'
require 'slim'
require 'pry'
require 'httparty'

#--------------------App_Routes--------------------#

get '/' do

  # staging
  base_url = "http://staging.reservebar.com/api/"
  auth = { username: 'admin@reservebar.com', password: 'Reservebar12' }

  # local
  # base_url = "http://localhost:3000/api/"
  # auth = {}

  @brands_resp = HTTParty.get(base_url + 'brands.json', basic_auth: auth)
  slim :index
end
