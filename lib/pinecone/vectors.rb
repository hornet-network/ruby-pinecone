module Pinecone
  class Vectors
    def initialize
    end

    # # POST Upsert
    # # Inserts or updates vectors in an index.
    # https://docs.pinecone.io/docs/insert-data#inserting-the-vectors
    def upsert(body)
      Pinecone::Client.json_post(path: "/vectors/upsert", parameters: body)
    end
  end
end