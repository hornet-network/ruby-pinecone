module Pinecone
  class Client
    def initialize(configuration = {})
      configuration.each do |k, v|
        Pinecone.configuration.send("#{k}=", v)
      end
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
      Pinecone::Client.json_post(path: '/query', parameters: body)
    end

    # # Vectors API
    #
    def vectors
      @vectors ||= Pinecone::Vectors.new
    end

    # # HTTP Helpers
    #
    def self.get(path:)
      HTTParty.get(
        uri(path: path),
        headers: headers
      )
    end

    def self.json_post(path:, parameters:)
      HTTParty.post(
        uri(path: path),
        headers: headers,
        body: parameters&.to_json
      )
    end

    def self.multipart_post(path:, parameters: nil)
      HTTParty.post(
        uri(path: path),
        headers: headers.merge({ "Content-Type" => "multipart/form-data" }),
        body: parameters
      )
    end

    def self.delete(path:)
      HTTParty.delete(
        uri(path: path),
        headers: headers
      )
    end

    private_class_method def self.uri(path:)
      Pinecone.configuration.base_uri + path
    end

    private_class_method def self.headers
      {
        "Content-Type" => "application/json",
        "Accept" => "application/json",
        "Api-Key" => Pinecone.configuration.api_key
      }
    end
  end
end