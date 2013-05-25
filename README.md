# Datacash

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
