module Pinecone
  class Client
    def initialize(api_key: nil, environment: nil)
      Pinecone.configuration.api_key = api_key if api_key
      Pinecone.configuration.environment = environment if environment
    end

    # # Vectors API
    #
    def indexes
      Pinecone::Index
    end

    # # HTTP Helpers
    #
    def self.get(path:, prefix: '')
      HTTParty.get(
        uri(path: path, prefix: prefix),
        headers: headers
      )
    end

    def self.json_post(path:, prefix: '', parameters:)
      HTTParty.post(
        uri(path: path, prefix: prefix),
        headers: headers,
        body: parameters&.to_json
      )
    end

    def self.json_patch(path:, prefix: '', parameters:)
      HTTParty.patch(
        uri(path: path, prefix: prefix),
        headers: headers,
        body: parameters&.to_json
      )
    end

    def self.multipart_post(path:, prefix: '', parameters: nil)
      HTTParty.post(
        uri(path: path, prefix: prefix),
        headers: headers.merge({ "Content-Type" => "multipart/form-data" }),
        body: parameters
      )
    end

    def self.delete(path:, prefix: '')
      HTTParty.delete(
        uri(path: path, prefix: prefix),
        headers: headers
      )
    end

    def self.project_name
      Thread.current[:project_name] ||= Pinecone::Client.get(prefix: 'controller', path: '/actions/whoami')['project_name']
    end

    private_class_method def self.uri(path:, prefix: '')
      base = [prefix, Pinecone.configuration.environment].compact.join('.')
      "https://#{base}.pinecone.io" + path
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