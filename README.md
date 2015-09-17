ReserveBar API Example
---------
Sinatra application interfacing with the ReserveBar API

Getting Started
-----
This application assumes Ruby 2.2.1 is installed.

``` bash
git clone https://github.com/ReserveBar1/reservebar_api_example.git
cd reservebar_api_example
bundle install
rackup config.ru
```

Stepping Through The API With Curl
----------------------------------

Get a list of products for a brand

```bash
curl -u admin@reservebar.com:Reservebar12 http://staging.reservebar.com/api/products.json\?brand\=baileys
```
Get the properties of a product.  Use The product id learned in the previous step

```bash
curl -u admin@reservebar.com:Reservebar12 http://staging.reservebar.com/api/products/438
```

Create an order

```bash
curl -u admin@reservebar.com:Reservebar12 -H "Content-Type: application/json" -X POST -d '{"order": { "line_items": { "0":  { "variant_id": "KOS", "quantity": "12" } } }}' https://staging.reservebar.com/api/orders
```

Begin Checkout
  * Use order number and order token returned from previous call

```bash
 curl -u admin@reservebar.com:Reservebar12 -H "Content-Type: application/json" -X PUT -d '{ "id": "R686515166", "order_token": "a648f1f034d0c6d8", "order": { "email": "user@test.com" } }' https://staging.reservebar.com/api/checkouts/R686515166
```

Address Step

```bash
 curl -u admin@reservebar.com:Reservebar12 -H "Content-Type: application/json" -X PUT -d '{ "id": "R686515166", "order_token": "a648f1f034d0c6d8", "order": { "email": "user@test.com", "ship_address_attributes": { "firstname": "First", "lastname": "Last", "address1": "123 First", "city": "New York", "zipcode": "10009", "phone": "1234567890", "state": "NY", "country_id": 214 } , "is_legal_age": true } }' https://staging.reservebar.com/api/checkouts/R686515166
```

Retrieve Valid Delivery Options

```bash
curl -u admin@reservebar.com:Reservebar12 http://staging.reservebar.com/api/shipping_methods
```

Choose Order Delivery Option

```bash
 curl -u admin@reservebar.com:Reservebar12 -H "Content-Type: application/json" -X PUT -d '{ "id": "R686515166", "order_token": "a648f1f034d0c6d8", "order": { "shipping_method_id": "7" } }' https://staging.reservebar.com/api/checkouts/R686515166
```

Pay With Credit Card
Set the address_id in the source_attributes section to the address_id returned after the address step

```bash
 curl -u admin@reservebar.com:Reservebar12 -H "Content-Type: application/json" -X PUT -d '{ "id": "R686515166", "order_token": "a648f1f034d0c6d8", "order": {  "has_accepted_terms": true, "payments_attributes": [{ "payment_method_id": "3", "source_attributes": { "first_name":  "First", "last_name": "Last", "number": "4111111111111111", "month": "08", "year": "2018", "verification_value": "123", "address_id": "376" }}] }}' https://staging.reservebar.com/api/checkouts/R686515166
```
