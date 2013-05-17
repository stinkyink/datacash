# Datacash

Please don't use this yet, I'm just coming up with ideas at the moment so please don't consider it production code :)

## Installation

Add this line to your application's Gemfile:

    gem 'datacash'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install datacash

## Usage

```ruby
client = Datacash::Client.new(
  client: "ABC1234",
  password: "29389q8iajf",
  environment: :live
)

session_request = Datacash::HPSSessionRequest.new(
  page_set: 0,
  3d_secure: false,
  third_man: false
)

response = client.post(session_request) # => Datacash::Response

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
