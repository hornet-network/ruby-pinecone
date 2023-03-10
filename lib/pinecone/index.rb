module Pinecone
  class Index
    class QueryError < StandardError; end

    attr_accessor :name
    def initialize(name:)
      self.name = name
    end

    def self.[](name)
      self.new(name: name)
    end

    def prefix
      "#{name}-#{Pinecone::Client.project_name}.svc"
    end

    # # Vectors API
    #
    def vectors
      @vectors ||= Pinecone::Vectors.new(index: self)
    end

    # # Get Index
    # # Lists all databases
    # https://docs.pinecone.io/docs/manage-indexes#getting-information-on-your-indexes
    def self.list
      indexes = Pinecone::Client.get(prefix: 'controller', path: "/databases")
      indexes.map{|i| self.new(name: i) }
    end

    # # POST Create
    # # Creates an index
    # https://docs.pinecone.io/docs/manage-indexes#creating-an-index
    def self.create(name:, params: {})
      defaults = {
        name: name,
        dimension: 128
      }
      body = defaults.merge(params.deep_symbolize_keys)
      Pinecone::Client.json_post(prefix: 'controller', path: "/databases", parameters: body)
      self.new(name: name)
    end

    # # POST Query
    # # Provide a vector and retrieve the top-k most similar vectors for each query
    # https://docs.pinecone.io/docs/query-data#sending-a-query
    def query(vector, options: {})
      defaults = {
        "includeValues": false,
        "includeMetadata": true,
        "topK": 5,
        "vector": vector
      }
      body = defaults.merge(options)
      result = Pinecone::Client.json_post(prefix: prefix, path: '/query', parameters: body)
      if !result.success?
        raise QueryError.new("Query failed with #{result.response.code} - #{result.parsed_response.to_s}")
      end
      result.parsed_response
    end

    # # Get Show
    # # Show database info
    # https://docs.pinecone.io/docs/manage-indexes#getting-information-on-your-indexes
    def describe
      Pinecone::Client.get(prefix: 'controller', path: "/databases/#{name}")
    end

    # # Get Show
    # # Show database info
    # https://docs.pinecone.io/docs/manage-indexes#getting-information-on-your-indexes
    def describe_index_stats
      Pinecone::Client.get(prefix: prefix, path: '/describe_index_stats')
    end

    # # PATCH Configure
    # # Creates an index
    # https://docs.pinecone.io/docs/manage-indexes#creating-an-index
    def configure(params:)
      Pinecone::Client.json_patch(prefix: 'controller', path: "/databases/#{name}", parameters: params)
    end

    # # DELETE
    # # Creates an index
    # https://docs.pinecone.io/docs/manage-indexes#deleting-an-index
    def delete
      Pinecone::Client.delete(prefix: 'controller', path: "/databases/#{name}")
    end

  end
end