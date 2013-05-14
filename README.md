# Simple Merchant

Please don't use this yet, I'm just coming up with ideas at the moment so please don't consider it production code :)

## Installation

Add this line to your application's Gemfile:

    gem 'simple_merchant'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_merchant

## Usage

```ruby
client = Datacash::Client.new(
  datacash_client: "ABC1234",
  datacash_password: "29389q8iajf",
  datacash_endpoint: "http://localhost:4000",
)

session_request = Datacash::SessionRequest.new(
  client: client
  datacash_page_set_id: 0,
  datacash_3d_secure_enabled: false
)

session_request.order_number = order.order_number

session_request.add_order_line(
  code: order_line.reference,
)

response = session_request.perform! # => Datacash::Response

if response.payment_url
  # off to the payment url to erm pay
else
  "OMG site broke!"
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
