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
client = Pinecone::Client.new(api_key: "access_token_goes_here", environment: "us-east1-gcp")
```

### With Config

For a more robust setup, you can configure the gem with your API keys, for example in a pinecone.rb initializer. Never hardcode secrets into your codebase - instead use something like dotenv to pass the keys safely into your environments.

```ruby
Pinecone.configuration.api_key = ENV.fetch('PINECONE_API_KEY')
Pinecone.configuration.environment = ENV.fetch('PINECONE_ENVIRONMENT')
```
Then you can create a client like this:

```ruby
client = Pinecone::Client.new
```

### Indexes

#### View Indexes
```ruby
client = Pinecone::Client.new

# Load all indexes
indexes = client.indexes.list

# Load specific index
index = client.indexes['my-index']

index.describe
# => {"database"=>{"name"=>"my-index", "metric"=>"cosine"...}}

index.describe_index_stats
#=> {"namespaces"=>{}, "dimension"=>1536, "indexFullness"=>0, "totalVectorCount"=>0}
```

#### Create Index
```ruby
index = client.indexes.create(name: 'my-new-index', params: {dimension: 1536})
```

#### Delete Index
```ruby
index = client.indexes['my-index']
index.delete
```

### Update an Index
```ruby
index = client.indexes['my-index']
index.configure(params: {pod_type: 's1.x2'})
```

#### Manage Vectors

##### Upsert
```ruby
client = Pinecone::Client.new
index = client.indexes['my-index']

body = {
  vectors: [
    {
      id: 'id-1',
      values: [0.1, 0.1, 0.1, 0.1, 0.1],
      metadata: {genre: 'comedy', year: 2020}
    },
    {
      id: 'id-2',
      values: [0.2, 0.2, 0.2, 0.2, 0.2],
      metadata: {genre: 'drama'}
    },
  ]
}

index.vectors.upsert(body)
```

##### Delete
```ruby
client = Pinecone::Client.new
index = client.indexes['my-index']
index.vectors.delete(ids: ['id-1', 'id-2'])
```

#### Query
```ruby
client = Pinecone::Client.new
index = client.indexes['my-index']

options = {
  "includeValues": false,
  "includeMetadata": true,
  "topK": 10,
}
index.query([1.0, 1.0], options: options)
# => {"results"=>[], "matches"=>[{"id"=>"id-1", "score"=>1, "values"=>[], "metadata"=>{"type"=>"Thing"}}, {"id"=>"id-2", "score"=>0.89825207, "values"=>[], "metadata"=>{"type"=>"Thing"}}], "namespace"=>""}

index.query(nil, options: options)
# => raise QueryError (Query failed with 400 - {"code"=>3, "message"=>"No query provided", "details"=>[]})
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
