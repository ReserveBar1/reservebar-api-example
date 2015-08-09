require 'sinatra'
require 'haml'
require 'pry'
require 'httparty'

# Setup
# staging
# base_url = 'http://staging.reservebar.com/api/'
# auth = { username: 'admin@reservebar.com', password: 'Reservebar12' }

# local
base_url = 'http://localhost:3000/api/'
auth = {}
# --------------------App_Routes--------------------#

get '/' do
  @brands_resp = HTTParty.get(base_url + 'brands.json', basic_auth: auth)
  @products = HTTParty.get("#{base_url}products.json?brand=Jameson",
                           basic_auth: auth)
  haml :index
end

get '/products/:product' do
  response = HTTParty.get("#{base_url}products/#{params[:product]}",
                          basic_auth: auth)
  @product = response['product']
  haml :product
end

post '/checkout' do
  haml :checkout
end
