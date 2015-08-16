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
auth = { username: 'admin@reservebar.com', password: 'Reservebar12' }
# --------------------App_Routes--------------------#

get '/' do
  @brands_resp = HTTParty.get(base_url + 'brands.json', basic_auth: auth)
  @brands = @brands_resp['brands'] || ['error']
  @products = HTTParty.get("#{base_url}products.json?brand=Jameson",
                           basic_auth: auth)
  haml :index
end

get '/brand_products/:brand' do
  @products = HTTParty.get("#{base_url}products.json?brand=#{params[:brand]}",
                           basic_auth: auth)
  puts
  puts @products.inspect
  puts
  haml :products, layout: false
end

get '/products/:product' do
  response = HTTParty.get("#{base_url}products/#{params[:product]}",
                          basic_auth: auth)
  @product = response['product']
  haml :product
end

post '/order' do
  puts "\n\nPARAMS: #{params}\n"
  body = { line_items: { '0' => { variant_id: params[:product_id],
                                   quantity: params[:quantity] } } }
  response = HTTParty.post("#{base_url}orders",
                           body: body,
                           basic_auth: auth)
  @order_status = response.body
  haml :order
end

post '/checkout' do
  haml :checkout
end


