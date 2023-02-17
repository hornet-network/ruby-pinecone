# Ruby Pinecone

Ruby library to make interacting with the Pinecone Vector Database API easier.
Format and workings inspired by https://github.com/alexrudall/ruby-openai

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-pinecone'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ruby-pinecone

## Usage

### Quickstart

For a quick test you can pass your token directly to a new client:

```ruby
client = Pinecone::Client.new(api_key: "access_token_goes_here", base_uri: "https://index_name-project_id.svc.environment.pinecone.io")
```

### With Config

For a more robust setup, you can configure the gem with your API keys, for example in a pinecone.rb initializer. Never hardcode secrets into your codebase - instead use something like dotenv to pass the keys safely into your environments.

```ruby
Pinecone.configure do |config|
    config.api_key = ENV.fetch('PINECONE_API_KEY')
    config.base_uri = ENV.fetch('PINECONE_BASE_URI')
end
```
Then you can create a client like this:

```ruby
client = Pinecone::Client.new
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruby-pinecone. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ruby-pinecone/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ruby Pinecone project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ruby-pinecone/blob/main/CODE_OF_CONDUCT.md).
