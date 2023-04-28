module Pinecone
  class Vectors
    attr_accessor :index
    def initialize(index:)
      self.index = index
    end

    # # POST Upsert
    # # Inserts or updates vectors in an index.
    # https://docs.pinecone.io/docs/insert-data#inserting-the-vectors
    def upsert(body)
      Pinecone::Client.json_post(prefix: index.prefix, path: "/vectors/upsert", parameters: body)
    end

    # https://docs.pinecone.io/docs/manage-data#fetching-vectors
    def fetch(ids:)
      Pinecone::Client.get(prefix: index.prefix, path: "/vectors/fetch?ids=#{ids.join(',')}")
    end

    # https://docs.pinecone.io/docs/manage-data#delete-vectors-by-id
    def delete(ids:, params: {})
      params.merge({
        ids: ids.join(',')
      })
      params = params.map{ |k, v| "#{k}=#{v}" }.join('&')
      Pinecone::Client.delete(prefix: index.prefix, path: "/vectors/delete?#{params}")
    end
  end
end