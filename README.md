# Datacash

DataCash, a MasterCard Company, is an international provider of credit / 
debit card processing and industry leading fraud / risk management solutions.

This library provides an idiomatic interface to the DataCash gateway. I would 
highly recommend reading the DataCash Developers Guide which is available in the
[Developers Area](https://testserver.datacash.com/software/download.cgi). You will
will need a [test login](https://testserver.datacash.com/software/integration.shtml)
to be able to download the developers guide and to play with the gateway.

## Configuration

```ruby
# Gemfile
gem 'datacash'

# config/initializers/datacash.rb
Datacash.configure do |config|
  config.client = "123456"
  config.password = "password1234"
  config.environment = :live || :test
end
# or
Datacash.configuration.client = "123456"
```

## Usage

You can play with the library using the console. Run ```rake console```
then configure using the method above.

### Query

```ruby
reference = "3403410491041490149314"
Datacash::Client.new.query(reference) # => Datacash::Response::Response
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
